# encoding: utf-8
require "i18n"

class TextTools
	def self.get_shingles(a_str, k)
		shingles = []
		if a_str == nil or a_str == ""
			return shingles
		end 
		if a_str.length >= k
			for i in 0..(a_str.length - k)
				shingles[i] = a_str[i..(i+k-1)]
			end
		end
		return shingles
	end

	def self.clean_text(campo)
		if campo.nil? || campo==""
			return ""
		else
			campo = campo.downcase().gsub(/º/, 'o').gsub(/ª/, 'a').strip()
			campo = I18n::transliterate(campo)
			campo = campo.gsub(/\p{M}/, '')
			return campo
		end
	end
end