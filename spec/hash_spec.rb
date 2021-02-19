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
end