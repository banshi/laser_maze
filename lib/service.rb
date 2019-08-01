module LaserMaze
  class Service
    class << self
      def exec
        validate_input_and_output

        LaserMaze::Solver.new.exec

        puts "Laser Maze solving completed"
      end

      def validate_input_and_output
        unless File.exists?(ARGV[0]) && File.file?(ARGV[0])
          raise RuntimeError.new("Input file is invalid or doesn't exist")
        end

        unless File.exists?(ARGV[1]) && File.file?(ARGV[1])
          raise RuntimeError.new("Output file is invalid or doesn't exist")
        end

        if File.zero?(ARGV[0])
          raise RuntimeError.new("Nothing to solve. Input file is blank")
        end
      end
    end
  end
end
