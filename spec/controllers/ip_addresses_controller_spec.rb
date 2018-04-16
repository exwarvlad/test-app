require 'rails_helper'

RSpec.describe IpAddressesController, type: :controller do
  describe '#GET index' do
    subject       { get :index, params: params }
    let!(:params) { {} }

    context 'when valid' do
      let!(:user)     { create :user }
      let!(:user_2nd) { create :user }
      let!(:address)  { create :ip_address, ip: '28.12.12.12' }
      let!(:post)     { create :post, ip_address: address, user: user }
      let!(:post_2nd) { create :post, ip_address: address, user: user_2nd }

      it do
        subject
        expect(JSON.parse(response.body).size).to eq(1)
        expect(JSON.parse(response.body).first).to eq(address.ip.to_s)
      end
    end
  end
end
