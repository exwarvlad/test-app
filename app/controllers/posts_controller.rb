class PostsController < ApplicationController
  def index
    render json: paginated_collection.pluck(:title, :description), status: 200
  end

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

  def paginated_collection
    Post.top.
      page(pagination_params[:page]).
      per(pagination_params[:per_page]).
      padding(pagination_params[:padding])
  end

  def pagination_params
    params.permit(:page, :per_page, :padding)
  end

  def permit_params
    params.require(:post).permit :title, :description, :user_login, :ip_address
  end
end
