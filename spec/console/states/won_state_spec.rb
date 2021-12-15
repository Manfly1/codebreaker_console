# frozen_string_literal: true

RSpec.describe States::WonState do
  subject(:won_state) { described_class.new(console) }

  let(:console) { instance_double(Console) }
  let(:game) { instance_double(CodebreakerManflyy::Game) }
  let(:code) { [1, 2, 3, 4] }
  let(:input) { %w[start rules stats hint yes no exit] }

  describe '#interact' do
    before do
      allow(console).to receive(:change_state_to)
      allow(console).to receive(:game).and_return(game)
      allow(game).to receive(:code).and_return(code)
      allow(game).to receive(:start_new_game)
      allow(STDIN).to receive(:gets).and_return(*input)
    end

    it 'puts win message if user has won' do
      allow(game).to receive(:won?).and_return(true)
      expect { won_state.interact }.to output(/#{I18n.t('won_state.game_won', code: code)}/).to_stdout
    end
 
    it 'puts save statistic message if user has won' do
      allow(game).to receive(:won?).and_return(true)
      allow(game).to receive(:save)
      allow(won_state).to receive(:input).and_return(input['yes'])
      expect { won_state.execute }.to output(/Do you want to save statistic?/).to_stdout
    end
  end
end
