require 'space'

describe Space do

    before [:each] do
        Space.create(name: 'test1', description: 'this is out first test', price: 10) #doesnt belong to us
        Space.create(name: 'test2', description: 'this is out second test', price: 20) #doesnt belong to us
        Space.create(name: 'test3', description: 'this is out third test', price: 30) #doesnt belong to us
    end

    describe '.all' do
        it 'shows a list of all spaces' do
            spaces = Space.all
            expect(spaces.length).to eq 3
        end
    end
  
    describe '.create' do
        it 'adds a space to the list of spaces' do
            Space.create(name: 'test5', description: 'this is out fifth test', price: 50) #does belong to us
            spaces = Space.all
            expect(spaces.length).to eq 4
        end
    end

end
