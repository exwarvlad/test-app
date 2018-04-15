class PostsController < ApplicationController
  def create
    if ((service = UserFindCreator.new(permit_params)) && (user = service.call)) &&
        ((service = IpAddressFindCreator.new(permit_params)) && (address = service.call)) &&
        ((service = PostCreator.
          new(permit_params.
            merge(user_id: user.id, ip_address_id: address.id))) && (post = service.call))

      render json: post, status: 201
    else
      render json: service.errors.full_messages, status: 422
    end
  end

  private

  def permit_params
    params.require(:post).permit :title, :description, :user_login, :ip_address
  end
end
