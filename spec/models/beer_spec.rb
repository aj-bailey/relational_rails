require 'rails_helper'

RSpec.describe Beer, type: :model do
  describe 'relationships' do
    it { should belong_to :brewery }
  end
end