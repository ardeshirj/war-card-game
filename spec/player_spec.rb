require 'spec_helper'

RSpec.describe Player do
  before :all do
    @player = Player.new(1, %w(A 8 J 5 Q))
  end
end
