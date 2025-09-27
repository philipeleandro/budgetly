require 'rails_helper'

RSpec.describe Budget, type: :model do
  subject(:budget) { build(:budget) }

  describe 'validations' do
    it { should validate_presence_of(:month) }
    it { should validate_presence_of(:year) }

    it { should validate_numericality_of(:month).only_integer }
    it { should validate_numericality_of(:year).only_integer }

    it { should validate_uniqueness_of(:month).scoped_to(:year, :user_id) }
  end
end
