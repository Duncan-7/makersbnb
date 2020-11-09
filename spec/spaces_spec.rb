require 'spaces'

describe Spaces do

    before[:each] do
        Spaces.add(name: 'test1', description: 'this is out first test', price: 10) #doesnt belong to us
        Spaces.add(name: 'test2', description: 'this is out second test', price: 20) #doesnt belong to us
        Spaces.add(name: 'test3', description: 'this is out third test', price: 30) #doesnt belong to us
    end
    
    describe '.all' do
        it 'shows a list of all spaces' do
            spaces = Spaces.all
            expect(spaces.length).to eq 3
        end
    end
    describe '.mine' do
        it 'shows the user a list of all of their spaces' do
            Spaces.add(name: 'test4', description: 'this is out fourth test', price: 40) #does belong to us
            spaces = Spaces.mine
            expect(spaces).to include('test4')
        end
    end
    describe '.add' do
        it 'adds a space to the list of spaces' do
            Spaces.add(name: 'test5', description: 'this is out fifth test', price: 50) #does belong to us
            spaces = Spaces.all
            expect(spaces.length).to eq 4
        end
    end
    
end