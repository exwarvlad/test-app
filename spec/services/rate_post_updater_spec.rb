require 'rails_helper'

RSpec.describe RatePostUpdater do
  describe '.call' do
    let(:service)    { described_class.new(params) }
    subject          { service.call }
    let(:user)       { create :user }
    let(:address)    { create :ip_address }
    let!(:post)      { create :post, user_id: user.id, ip_address_id: address.id }
    let(:rate_value) { 4 }
    let(:params)     { {post_id: post.id, rate_value: rate_value} }

    context 'when valid' do
      context 'rate_value' do
        it { expect { subject }.to change { Rate.count }.by(1) }
        it { expect(subject.average_rate).to eq(rate_value) }
      end

      context 'with calculated rate_value' do
        let!(:rates) { create_list(:rate, 10, value: 5, post_id: post.id) }

        it { expect(subject.average_rate).to eq(4.909090909090909) }
      end
    end

    context 'when invalid' do
      context 'params' do
        let(:params) { {id: '12', value: rate_value} }

        it { expect { subject }.to change { Rate.count }.by(0) }
        it do
          subject
          expect(service.errors.full_messages).
            to eq(['Post Post with id:  not found',
                   "Post can't be blank",
                   "Rate value can't be blank",
                   'Rate value is not a number',])
        end
      end

      context 'post id' do
        let(:params) { {post_id: '12', rate_value: rate_value} }

        it { expect { subject }.to change { Rate.count }.by(0) }
        it do
          subject
          expect(service.errors.full_messages).
            to eq(['Post Post with id: 12 not found'])
        end
      end

      context 'rate value' do
        let(:params) { {post_id: post.id, rate_value: 10} }

        it { expect { subject }.to change { Rate.count }.by(0) }
        it do
          subject
          expect(service.errors.full_messages).
            to eq(['Rate value must be less than or equal to 5'])
        end
      end
    end
  end
end
