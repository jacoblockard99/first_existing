require 'spec_helper'

RSpec.describe Hash do
  describe '#default!' do
    context 'with only a key' do
      context 'when the key exists' do
        it 'does nothing' do
          h = { key: :value }
          h.default! :key
          expect(h.length).to eq 1
          expect(h[:key]).to eq :value
        end

        it 'returns the existing value' do
          h = { key: :value }
          expect(h.default!(:key)).to eq :value
        end
      end

      context 'when the key does not exist' do
        it 'does nothing' do
          h = {}
          h.default! :key
          expect(h.length).to eq 0
        end

        it 'returns nil' do
          expect({}.default!(:key)).to be_nil
        end
      end
    end

    context 'with a valid fallback' do
      context 'when the key exists' do
        it 'does nothing' do
          h = { key: :value }
          h.default! :key, :new
          expect(h[:key]).to eq :value
        end

        it 'returns the existing value' do
          h = { key: :value }
          expect(h.default!(:key, :new)).to eq :value
        end
      end

      context 'when the key doe not exist' do
        it 'uses the fallback' do
          h = {}
          h.default! :key, :new
          expect(h[:key]).to eq :new
        end

        it 'returns the fallback' do
          expect({}.default!(:key, :new)).to eq :new
        end
      end
    end

    context 'with multiple fallbacks' do
      context 'when all arguments are nil' do
        it 'does nothing' do
          h = {}
          h.default! :key, nil, nil, nil, nil, nil
          expect(h.length).to eq 0
        end

        it 'returns nil' do
          expect({}.default!(:key, nil, nil, nil, nil)).to be_nil
        end
      end

      context 'when the first fallbacks are nil' do
        it 'uses the first existing fallback' do
          h = {}
          h.default! :key, nil, nil, nil, :existing, :wrong, nil
          expect(h[:key]).to eq :existing
        end

        it 'returns the fallback' do
          expect({}.default!(:key, nil, nil, nil, :existing, :wrong, nil)).to eq :existing
        end
      end
    end
  end

  describe '#required' do
    context 'when given one option' do
      context 'when the option exists' do
        it 'does nothing' do
          h = { key: :value }
          expect { h.required! :key }.to_not raise_error
        end
      end

      context 'when the option does not exist' do
        it 'raises an appropriate error' do
          h = {}
          expect { h.required! :name}.to raise_error "The 'name' option is required!"
        end
      end
    end

    context 'when given multiple options' do
      context 'when all the options exist' do
        it 'does nothing' do
          h = { one: :value1, two: :value2, three: :value3, four: :value4 }
          expect { h.required! :one, :two, :three, :four }.to_not raise_error
        end
      end

      context 'when an option does not exist' do
        it 'raises an appropriate error' do
          h = { two: :value2, three: :value3 }
          expect { h.required! :one, :two, :three }.to raise_error "The 'one' option is required!"

          h = { one: :value1, three: :value3 }
          expect { h.required! :one, :two, :three }.to raise_error "The 'two' option is required!"

          h = { one: :value1, two: :value2 }
          expect { h.required! :one, :two, :three }.to raise_error "The 'three' option is required!"
        end
      end
    end
  end
end