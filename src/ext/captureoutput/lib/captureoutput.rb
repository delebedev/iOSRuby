class CaptureOutput < IO
    def write(text)
        captured_write(text);
    end
end

buf = CaptureOutput.new

$defout = buf
$stderr = buf
$stdout = buf