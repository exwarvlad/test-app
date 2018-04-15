require 'resolv'

class IpAddressFindCreator
  include ActiveModel::Validations

  attr_accessor :ip

  validates :ip, presence: true
  validate :check_ip_address

  def initialize(params)
    @ip = params[:ip_address]
  end

  def call
    return nil unless valid?

    address.tap do |addr|
      addr.ip = ip
    end.save

    address
  end

  private

  def address
    @address ||= IpAddress.find_by(ip: ip) || IpAddress.new
  end

  def check_ip_address
    case ip
    when Resolv::IPv4::Regex
      true
    when Resolv::IPv6::Regex
      true
    else
      errors.add(:ip, 'It`s not a valid ip address.')
    end
  end
end
