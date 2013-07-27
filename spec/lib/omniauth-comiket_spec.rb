require 'spec_helper'

def app; lambda {|env| [200, {}, ["hello"]]} end
describe OmniAuth::Strategies::Comiket do
  let(:strategy) { OmniAuth::Strategies::Comiket.new(app) }
  before { OmniAuth.config.test_mode = true }
  after { OmniAuth.config.test_mode = false }

  describe '#client' do
    subject { strategy }
    it 'urls are production' do
      expect(subject.client.site).to match %r{https://auth1.circle.ms}
    end
  end
end

describe OmniAuth::Strategies::ComiketSandbox do
  let(:strategy) { OmniAuth::Strategies::ComiketSandbox.new(app) }
  before { OmniAuth.config.test_mode = true }
  after { OmniAuth.config.test_mode = false }

  describe '#client' do
    subject { strategy }
    it 'urls are production' do
      expect(subject.client.site).to match %{https://auth1-sandbox.circle.ms}
    end
  end
end
