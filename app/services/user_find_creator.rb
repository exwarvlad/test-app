class UserFindCreator
  include ActiveModel::Validations

  attr_accessor :login

  validates :login, presence: true
  validates :login, length: {minimum: 5, maximum: 100}

  def initialize(params)
    @login = params[:user_login]
  end

  def call
    return nil unless valid?

    user.tap do |u|
      u.login = login
    end.save

    user
  end

  private

  def user
    @user ||= User.find_by(login: login) || User.new
  end
end
