module LaserMaze
  class Beam
    FORWARD_MIRROR = { E: :N, N: :E, S: :W, W: :S }
    BACKWARD_MIRROR = { W: :N, N: :W, S: :E, E: :S }

    attr_reader :maze, :current_x, :current_y, :path

    def initialize(maze)
      @maze = maze
      @current_x = maze.start_x
      @current_y = maze.start_y
      @direction = maze.start_direction
      @path = {}
    end

    def can_travel_to_next_square?
      in_bounds?
    end

    def travel_to_next_square!
      move

      if in_bounds?
        record_current_position_in_path
        change_direction_if_necessary
      end
    end

    def last_x
      return path.keys.last[0] if path.keys.last
      start_x
    end

    def last_y
      return path.keys.last[1] if path.keys.last
      start_y
    end

    def square_count
      path.keys.size
    end

    def ==(other_beam)
      current_x == other_beam.current_x && current_y == other_beam.current_y
    end

    private

    def in_bounds?
      (0...@maze.width) === @current_x && (0...@maze.height) === @current_y
    end

    def record_current_position_in_path
      @path[[current_x, current_y]] = true
    end

    def move
      case @direction
      when :N
        @current_y += 1
      when :E
        @current_x += 1
      when :S
        @current_y -= 1
      when :W
        @current_x -= 1
      end
    end

    def change_direction_if_necessary
      return if current_square_empty?
      @direction = FORWARD_MIRROR[@direction] if forward_mirror?
      @direction = BACKWARD_MIRROR[@direction] if backward_mirror?
    end

    def current_square_empty?
      maze.pos(current_x, current_y) == :empty
    end

    def forward_mirror?
      maze.pos(current_x, current_y) == "/"
    end

    def backward_mirror?
      maze.pos(current_x, current_y) == "\\"
    end
  end
end
