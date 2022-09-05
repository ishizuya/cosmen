require 'rails_helper'

describe 'Userモデルのテスト' do
  it "有効な会員の場合は保存されるか" do
    expect(FactoryBot.build(:user)).to be_valid
  end
end