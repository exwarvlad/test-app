class PostCreator
  include ActiveModel::Validations

  attr_accessor :title, :description, :user_id, :ip_address_id

  validates :title, :description, :user_id, :ip_address_id, presence: true

  def initialize(params)
    @title          = params[:title]
    @description    = params[:description]
    @user_id        = params[:user_id]
    @ip_address_id  = params[:ip_address_id]
  end

  def call
    return nil unless valid?

    post.tap do |p|
      p.ip_address_id = ip_address_id
      p.user_id       = user_id
      p.title         = title
      p.description   = description
    end.save

    post
  end

  private

  def post
    @post ||= Post.new
  end
end
