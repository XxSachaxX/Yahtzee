require_relative '../combinations_dictionary'
describe CombinationsDictionary do
  it 'contains a mapping of digits categories with the digit they represent' do
    expect(CombinationsDictionary.digit_categories).to eq({
                                                              ones: 1,
                                                              twos: 2,
                                                              threes: 3,
                                                              fours: 4,
                                                              fives: 5,
                                                              sixes: 6
                                                            })
  end

  context 'given a digit category' do
    it 'can return its integer counterpart' do
      expect(CombinationsDictionary.digit_for(:ones)).to eq(1)
    end
  end
end