shared_examples_for 'a relation that returns one tuple' do
  describe '#one' do
    it 'returns first tuple' do
      rom.relations.users.delete(name: 'Joe', email: 'joe@doe.org')
      expect(users.one).to eql(name: 'Jane', email: 'jane@doe.org')
    end

    it 'raises error when there is more than one tuple' do
      expect { users.one }.to raise_error(ROM::TupleCountMismatchError)
    end
  end

  describe '#one!' do
    it 'returns first tuple' do
      rom.relations.users.delete(name: 'Joe', email: 'joe@doe.org')
      expect(users.one!).to eql(name: 'Jane', email: 'jane@doe.org')
    end

    it 'raises error when there is no tuples' do
      rom.relations.users.delete(name: 'Jane', email: 'jane@doe.org')
      rom.relations.users.delete(name: 'Joe', email: 'joe@doe.org')

      expect { users.one! }.to raise_error(ROM::TupleCountMismatchError)
    end
  end
end
