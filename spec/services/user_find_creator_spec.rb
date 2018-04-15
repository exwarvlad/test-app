require 'rails_helper'

RSpec.describe UserFindCreator do
  let(:service) { described_class.new(params) }

  describe '.initialize' do
    subject { service.login }
    let(:user) { create :user }

    context 'when valid' do
      let(:params) { {user_login: user.login} }
      it { should eq(user.login) }
    end

    context 'when invalid' do
      let(:params) { {login: user.login} }

      it { should_not eq(user.login) }
      it { should eq(nil) }
    end
  end

  describe '.call' do
    let!(:user) { create :user, login: 'george.april' }
    subject { service.call }

    context 'when valid' do
      let(:params) { {user_login: user.login} }

      context 'user exists in db' do
        it { expect { subject }.to change { User.count }.by(0) }
        it { expect(service.errors.full_messages).to eq([]) }
        it { expect(subject).to be_kind_of(User) }
      end

      context 'user being inserted to db' do
        let(:params) { {user_login: 'mic.schnauss'} }

        it { expect { subject }.to change { User.count }.by(1) }
        it { expect(service.errors.full_messages).to eq([]) }
        it { expect(subject).to be_kind_of(User) }
      end
    end

    context 'when invalid' do
      context 'login blank' do
        let(:params) { {user_login: ''} }

        it { expect { subject }.to change { User.count }.by(0) }
        it do
          subject
          expect(service.errors.full_messages).
            to eq(["Login can't be blank",
                   'Login is too short (minimum is 5 characters)',])
        end
      end

      context 'login invalid' do
        let(:params) { {user_login: 'shor'} }

        it { expect { subject }.to change { User.count }.by(0) }
        it do
          subject
          expect(service.errors.full_messages).
            to eq(['Login is too short (minimum is 5 characters)'])
        end
      end
    end
  end
end
