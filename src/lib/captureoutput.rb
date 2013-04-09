class CaptureOutput < IO
	def initialize
		super(2)
	end
    def write(text)
        captured_write(text);
    end
end

buf = CaptureOutput.new

$stderr = buf
$stdout = buf