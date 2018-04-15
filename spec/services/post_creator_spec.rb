require 'rails_helper'

RSpec.describe PostCreator do
  let(:service) { described_class.new(params) }

  describe '.call' do
    subject { service.call }

    context 'when valid' do
      let(:user)    { create :user }
      let(:address) { create :ip_address }
      let(:post)    { build :post }

      let(:params) do
        {user_id: user.id, ip_address_id: address.id,
         title: post.title, description: post.description,}
      end

      it { expect { subject }.to change { Post.count }.by(1) }
      it { expect(service.errors.full_messages).to eq([]) }
      it { expect(subject).to be_kind_of(Post) }
    end

    context 'when invalid' do
      let(:params) { {} }

      it { expect { subject }.to change { Post.count }.by(0) }
      it { expect(subject).to eq(nil) }
      it do
        subject
        expect(service.errors.full_messages).
          to eq(["Title can't be blank",
                 "Description can't be blank",
                 "User can't be blank",
                 "Ip address can't be blank",])
      end
    end
  end
end
