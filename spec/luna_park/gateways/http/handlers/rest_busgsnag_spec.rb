# frozen_string_literal: true

module LunaPark
  module Gateways
    module Http
      module Handlers
        RSpec.describe RestBugsnag do
          let(:handler) { described_class.new }

          let(:title)     { 'custom action' }
          let(:request)   { Requests::Base.new url: 'http://example.com/api/action' }

          describe '#error' do
            let(:response) { double(code: 403, headers: nil, message: '') }

            subject { handler.error(title, response: response, request: request) }
            it { expect { subject }.to raise_error Http::Errors::RestBugsnag::Diagnostic }

            context 'when error skipped' do
              let(:handler) { described_class.new skip_errors: [403] }

              it { expect { subject }.to_not raise_error }
            end
          end

          describe '#timeout_error' do
            subject { handler.timeout_error(title, request: request) }
            it { expect { subject }.to raise_error Http::Errors::RestBugsnag::Timeout }

            context 'when error skipped' do
              let(:handler) { described_class.new skip_errors: [:timeout] }

              it { expect { subject }.to_not raise_error }
            end
          end
        end
      end
    end
  end
end
