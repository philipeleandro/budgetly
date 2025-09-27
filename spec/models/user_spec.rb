require 'rails_helper'

RSpec.describe User do
  subject(:user) { build(:user) }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }

    it { should validate_uniqueness_of(:email).case_insensitive }
  end
end
