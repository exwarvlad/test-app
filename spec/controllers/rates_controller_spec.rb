require 'rails_helper'

RSpec.describe RatesController, type: :controller do
  describe '#create' do
    subject           { post :create, params: params }
    let(:user)        { create(:user) }
    let(:address)     { create(:ip_address) }
    let!(:post_model) { create(:post, user_id: user.id, ip_address_id: address.id) }
    let(:rate_value)  { 4 }
    let(:params)      { {post_id: post_model.id, rate: {value: rate_value}} }

    context 'when valid' do
      it { expect { subject }.to change { Rate.count }.by(1) }
      it do
        subject
        expect(JSON.parse(response.body).keys).
          to eq(%w[average_rate])
        expect(response.status).to eq(200)
      end
    end

    context 'when invalid' do
      context 'rate value' do
        let(:params) { {post_id: post_model.id, rate: {value: -20}} }

        it { expect { subject }.to change { Rate.count }.by(0) }
        it do
          subject
          expect(JSON.parse(response.body)).
            to eq('rate_value' => ['must be greater than or equal to 1'])
          expect(response.status).to eq(422)
        end
      end
    end
  end
end
