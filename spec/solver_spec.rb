describe 'LaserMaze::Solver' do
  context 'valid maze' do
    let(:output) { 'foobar.txt' }
    let(:input) { './spec/sample_mazes/valid.txt' }
    let(:output_file) { File.readlines(output) }

    before { LaserMaze::Solver.new(input, output).exec }

    after { File.delete(output) }

    it 'has correct content' do
      expect(output_file.length).to eq(2)
      expect(output_file[0]).to eq("9\n")
      expect(output_file[1]).to eq("0 0\n")
    end
  end

  context 'starting in a loop' do
    let(:output) { 'foobar.txt' }
    let(:input) { './spec/sample_mazes/loop.txt' }
    let(:output_file) { File.readlines(output) }

    before { LaserMaze::Solver.new(input, output).exec }

    after { File.delete(output) }

    it 'has correct content' do
      expect(output_file.length).to eq(1)
      expect(output_file[0]).to eq("-1\n")
    end
  end
end
