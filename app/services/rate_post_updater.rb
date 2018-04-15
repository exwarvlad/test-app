class RatePostUpdater
  include ActiveModel::Validations

  MAX_RATE = 5
  MIN_RATE = 1

  attr_accessor :post_id, :rate_value

  validate :check_post
  validates :post_id, :rate_value, presence: true
  validates :rate_value, numericality: {greater_than_or_equal_to: MIN_RATE,
                                        less_than_or_equal_to: MAX_RATE,}

  def initialize(params)
    @post_id    = params[:post_id]
    @rate_value = params[:rate_value]
  end

  def call
    return nil unless valid?

    post.tap do |p|
      p.rates.create(post_id: p.id, value: rate_value)
      p.average_rate = p.rates.pluck(:value).inject(:+).to_f / p.rates.size
    end.save

    post
  end

  private

  attr_accessor :rate

  def post
    @post ||= Post.find_by(id: post_id)
  end

  def check_post
    return true if post.present?
    errors.add(:post_id, "Post with id: #{post_id} not found")
  end
end
