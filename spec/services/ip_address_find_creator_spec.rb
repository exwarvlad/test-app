require 'rails_helper'

RSpec.describe IpAddressFindCreator do
  let(:service) { described_class.new(params) }

  describe '.call' do
    subject { service.call }

    context 'when valid' do
      let!(:address) { create(:ip_address, ip: '28.13.14.156') }

      context 'ip exists in db' do
        let(:params) { {ip_address: address.ip.to_s} }

        it { expect { subject }.to change { IpAddress.count }.by(0) }
        it { expect(service.errors.full_messages).to eq([]) }
        it { expect(subject).to be_kind_of(IpAddress) }
      end

      context 'ip being inserted in db' do
        let(:params) { {ip_address: '12.12.1.5'} }

        it { expect { subject }.to change { IpAddress.count }.by(1) }
        it { expect(service.errors.full_messages).to eq([]) }
        it { expect(subject).to be_kind_of(IpAddress) }
      end
    end

    context 'when invalid' do
      context 'ip blank' do
        let(:params) { {ip_address: ''} }

        it { expect { subject }.to change { IpAddress.count }.by(0) }
        it { expect(subject).to eq(nil) }
        it do
          subject
          expect(service.errors.full_messages).
            to eq(["Ip can't be blank", 'Ip It`s not a valid ip address.'])
        end
      end

      context 'ip invalid' do
        let(:params) { {ip_address: '24.22.258.302'} }

        it { expect { subject }.to change { IpAddress.count }.by(0) }
        it { expect(subject).to eq(nil) }
        it do
          subject
          expect(service.errors.full_messages).to eq(['Ip It`s not a valid ip address.'])
        end
      end
    end
  end
end
