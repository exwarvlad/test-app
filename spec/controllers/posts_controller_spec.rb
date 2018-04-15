require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe 'POST #create' do
    subject { post :create, params: params }

    let(:params) do
      {
        post: {
          title: 'This is title',
          description: 'Description',
          user_login: 'george.april',
          ip_address: '28.12.44.18',
        },
      }
    end

    context 'when valid' do
      let!(:user)    { create :user, login: 'george.april' }
      let!(:address) { create :ip_address, ip: '28.12.44.18' }

      context 'user and address exists in db' do
        it { expect { subject }.to change { User.count }.by(0) }
        it { expect { subject }.to change { IpAddress.count }.by(0) }
        it { expect { subject }.to change { Post.count }.by(1) }
        it do
          subject
          expect(response.status).to eq(201)
        end
      end

      context 'user exists in db' do
        let(:params) { super().deep_merge(post: {ip_address: '12.12.12.12'}) }

        it { expect { subject }.to change { IpAddress.count }.by(1) }
        it { expect { subject }.to change { User.count }.by(0) }
        it { expect { subject }.to change { Post.count }.by(1) }
        it do
          subject
          expect(response.status).to eq(201)
        end
      end

      context 'no nested model in db' do
        let(:params) do
          super().deep_merge(post: {ip_address: '16.16.16.16', user_login: 'newone.12'})
        end

        it { expect { subject }.to change { User.count }.by(1) }
        it { expect { subject }.to change { IpAddress.count }.by(1) }
        it { expect { subject }.to change { Post.count }.by(1) }
        it do
          subject
          expect(response.status).to eq(201)
        end
      end
    end

    context 'when invalid' do
      context 'user' do
        let(:params) { super().deep_merge(post: {user_login: ''}) }

        it { expect { subject }.to change { User.count }.by(0) }
        it { expect { subject }.to change { IpAddress.count }.by(0) }
        it { expect { subject }.to change { Post.count }.by(0) }
        it do
          subject
          expect(response.status).to eq(422)
          expect(response.body).
            to eq("[\"Login can't be blank\",\"Login is too short (minimum is 5 characters)\"]")
        end
      end

      context 'ip_address' do
        context 'blank' do
          let(:params) { super().deep_merge(post: {ip_address: ''}) }

          it { expect { subject }.to change { User.count }.by(1) }
          it { expect { subject }.to change { IpAddress.count }.by(0) }
          it { expect { subject }.to change { Post.count }.by(0) }
          it do
            subject
            expect(response.status).to eq(422)
            expect(response.body).
              to eq("[\"Ip can't be blank\",\"Ip It`s not a valid ip address.\"]")
          end
        end

        context 'invalid' do
          let(:params) { super().deep_merge(post: {ip_address: '123.257.257.123'}) }

          it { expect { subject }.to change { User.count }.by(1) }
          it { expect { subject }.to change { IpAddress.count }.by(0) }
          it { expect { subject }.to change { Post.count }.by(0) }
          it do
            subject
            expect(response.status).to eq(422)
            expect(response.body).
              to eq('["Ip It`s not a valid ip address."]')
          end
        end

        context 'post' do
          context 'blank' do
            let(:params) { super().deep_merge(post: {title: '', description: ''}) }

            it { expect { subject }.to change { User.count }.by(1) }
            it { expect { subject }.to change { IpAddress.count }.by(1) }
            it { expect { subject }.to change { Post.count }.by(0) }
            it do
              subject
              expect(response.status).to eq(422)
              expect(response.body).
                to eq("[\"Title can't be blank\",\"Description can't be blank\"]")
            end
          end
        end
      end
    end
  end
end
