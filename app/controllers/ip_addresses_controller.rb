class IpAddressesController < ApplicationController
  def index
    render json: paginated_collection, status: 200
  end

  private

  def paginated_collection
    Kaminari.paginate_array(IpAddress.unique_address_multiple_use).
      page(pagination_params[:page]).
      per(pagination_params[:per_page]).
      padding(pagination_params[:padding])
  end

  def pagination_params
    params.permit(:page, :per_page, :padding)
  end
end
