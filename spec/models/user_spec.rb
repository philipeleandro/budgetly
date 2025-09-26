require 'rails_helper'

RSpec.describe User do
  subject { build(:user) }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
  end
end
