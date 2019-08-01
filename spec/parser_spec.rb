describe 'LaserMaze::Parser' do
  describe 'valid maze' do
    before(:all) do
      @valid_maze = LaserMaze::Parser.build_maze('./spec/sample_mazes/valid.txt')
    end

    it 'has correct starting direction' do
      expect(@valid_maze.start_direction).to be(:S)
    end

    it 'has correct height' do
      expect(@valid_maze.height).to be(6)
    end

    it 'has correct width' do
      expect(@valid_maze.width).to be(5)
    end

    it 'has mirrors on correct positions' do
      expect(@valid_maze.pos(3, 4)).to eq("/")
      expect(@valid_maze.pos(3, 0)).to eq("/")
      expect(@valid_maze.pos(1, 2)).to eq("\\")
      expect(@valid_maze.pos(3, 2)).to eq("\\")
      expect(@valid_maze.pos(4, 3)).to eq("\\")
    end

    it 'has empty squares on correct positions' do
      expect(@valid_maze.pos(3, 3)).to eq(:empty)
      expect(@valid_maze.pos(0, 4)).to eq(:empty)
      expect(@valid_maze.pos(4, 2)).to eq(:empty)
      expect(@valid_maze.pos(1, 3)).to eq(:empty)
    end
  end

  describe 'invalid maze' do
    let(:invalid_maze) { './spec/sample_mazes/invalid.txt' }

    it 'raises error' do
      expect{ LaserMaze::Parser.build_maze(invalid_maze) }.to raise_error(RuntimeError)
    end
  end
end
