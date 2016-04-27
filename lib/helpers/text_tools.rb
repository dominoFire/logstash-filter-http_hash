class TextTools
	def self.get_shingles(a_str, k)
		shingles = []
		if a_str == nil or a_str == ""
			return shingles
		end 
		if a_str.length >= k
			for i in 0..(a_str.length - k + 1)
				shingles[i] = a_str[i..(i+k-1)]
			end
		end
		return shingles
	end
end