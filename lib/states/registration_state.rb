# frozen_string_literal: true
module States
class RegistrationState < ConsoleState
  def interact
    create_game_instances
    change_state_to(:game_state)
  rescue CodebreakerManflyy::Validation::GameError => e
    puts e.message
    retry
  end

  private

  def create_game_instances
    @console.create_user(name: ask_name) unless @console.user
    @console.create_game(difficulty: ask_difficulty)
  end

  def ask_name
    puts I18n.t('registration_state.ask_user_name')
    input = $stdin.gets.chomp
    input == COMMANDS[:exit] ? (raise Errors::StopGameError) : input
  end

  def ask_difficulty
    puts I18n.t('registration_state.ask_difficulty', easy: DIFFICULTIES[:easy], medium: DIFFICULTIES[:medium], hard: DIFFICULTIES[:hell])
    input = $stdin.gets.chomp.downcase
    input == COMMANDS[:exit] ? (raise Errors::StopGameError) : input
  end
end
end