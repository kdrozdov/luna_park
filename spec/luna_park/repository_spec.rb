# frozen_string_literal: true

require 'luna_park/repositories/sequel'

module LunaPark
  RSpec.describe Repository do
    subject(:repo) { described_class.new }

    it 'extended with extension DataMapper' do
      is_expected.to be_a Extensions::DataMapper
    end
  end
end
