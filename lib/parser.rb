module LaserMaze
  class Parser
    class << self
      attr_accessor :maze, :start_x, :start_y, :direction, :mirror

      def build_maze(input_file = ARGV[0])
        File.open(input_file) do |f|
          f.each_with_index do |line, index|
            @start_x, @start_y = line.scan(/\d+/).map(&:to_i)

            if index == 0
              parse_first_line
            else
              @direction = line.scan(/[WESN]/).first
              @mirror = line.scan(/[\/\\]/).first
              parse_line
            end
          end
        end
        maze
      end

      def parse_first_line
        raise RuntimeError.new("Zero dimension maze") if start_x == 0 || start_y == 0
        @maze = LaserMaze::Maze.new(start_x, start_y)
      end

      def parse_line
        if direction
          @maze.start_x = start_x
          @maze.start_y = start_y
          @maze.start_direction = direction.intern
        end

        @maze[start_y][start_x] = mirror if mirror
      end
    end
  end
end
