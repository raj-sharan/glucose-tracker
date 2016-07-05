module ApplicationHelper

	def get_user_types
		Role.all.collect{|role| [role.name, role.id]}
	end

	def get_min_level(blood_glucose_levels)
		return 0 unless blood_glucose_levels.present?
		blood_glucose_levels.min_level.map(&:min_level).first
	end

	def get_avg_level(blood_glucose_levels)
		return 0 unless blood_glucose_levels.present?
		blood_glucose_levels.avg_level.map(&:avg_level).first
	end

	def get_max_level(blood_glucose_levels)
		return 0 unless blood_glucose_levels.present?
		blood_glucose_levels.max_level.map(&:max_level).first
	end
end
