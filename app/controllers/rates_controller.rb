class RatesController < ApplicationController
  def create
    if (service = RatePostUpdater.new(post_id: params[:post_id], rate_value: permit_params[:value])) &&
        (post = service.call)
      render json: {average_rate: post.average_rate}, status: 200
    else
      render json: service.errors, status: 422
    end
  end

  private

  def permit_params
    params.require(:rate).permit :value
  end
end
