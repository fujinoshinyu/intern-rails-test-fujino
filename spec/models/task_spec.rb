require 'rails_helper'

describe Task, type: :model do
  let(:user) { create(:user) }

  let(:six_digit_number) { Faker::Number.number(digits: 6) }
  let(:three_digit_number) { Faker::Number.number(digits: 3) }

  let(:valid_member_id) { "#{six_digit_number}-#{three_digit_number}-#{six_digit_number}" }
  let(:invalid_member_id) { "#{three_digit_number}-#{three_digit_number}-#{three_digit_number}" }

  let(:valid_benefit_station_user) { BenefitStationUser.new(user_id: user.id, member_id: valid_member_id) }
  let(:invalid_benefit_station_user) { BenefitStationUser.new(user_id: user.id, member_id: invalid_member_id) }

  describe 'validationのテスト（6桁-3桁-6桁のクーポンコード以外を弾けるか)' do
    context 'saveする時にvalidationが効いているか' do
      it 'saveされること' do
        expect(valid_benefit_station_user.save).to be_truthy
      end

      it 'saveされないこと' do
        expect(invalid_benefit_station_user.save).to be_falsey
      end
    end

    context 'updateする時にvalidationが効いているか' do
      let(:updated_valid_member_id) { "#{six_digit_number}-#{three_digit_number}-#{six_digit_number}" }
      let(:updated_invalid_member_id) { "#{three_digit_number}-#{three_digit_number}-#{three_digit_number}" }

      it 'updateされること' do
        expect(valid_benefit_station_user.update(member_id: updated_valid_member_id)).to be_truthy
      end

      it 'updateされないこと' do
        expect(invalid_benefit_station_user.update(member_id: updated_invalid_member_id)).to be_falsey
      end
    end
  end
end

