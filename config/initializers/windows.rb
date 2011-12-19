if Bundler::WINDOWS
	require 'nkf'

	class << $stdout
		def write_with_conversion(str)
			write_without_conversion NKF.nkf('-sxm0', str.to_s)
		end
		alias_method_chain :write, :conversion
	end
end