module LaserMaze
  class Solver
    attr_reader :maze, :view, :beam, :next_step_beam

    def initialize(input_file = ARGV[0], output_file = ARGV[1])
      @maze = LaserMaze::Parser.build_maze(input_file)
      @beam = LaserMaze::Beam.new(maze)
      @next_step_beam = LaserMaze::Beam.new(maze)
      @found_loop = false
      @output_file = output_file
    end

    def exec
      while beam.can_travel_to_next_square?
        beam.travel_to_next_square!

        break if in_loop?
      end

      output_results
    end

    def in_loop?
      2.times do
        next_step_beam.travel_to_next_square! if next_step_beam.can_travel_to_next_square?
      end

      if beam == next_step_beam && next_step_beam.can_travel_to_next_square?
        return @found_loop = true
      end

      false
    end

    private

    def output_results
      File.open(@output_file, 'w+') do |f|
        if @found_loop
          f.puts '-1'
        else
          f.puts beam.square_count
          f.puts "#{beam.last_x} #{beam.last_y}"
        end
      end
    end
  end
end
