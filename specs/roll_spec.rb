require_relative '../roll'

describe Roll do
  context 'A roll' do
    it 'is always made of five dices' do
      expect(Roll.new.dices.length).to eq(5)
    end

    it 'is made of numbers between 1 and 6' do
      expect(Roll.new.dices.sum).to be <= 30
    end
  end
end