require 'space'

describe Space do
    describe '.all' do
        it'returns all spaces' do
          spaces = Space.all
          expect(spaces).to include 'Space A'
        end
    end
end