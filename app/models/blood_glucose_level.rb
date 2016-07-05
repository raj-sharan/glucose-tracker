class GlucoseLevelValidator < ActiveModel::Validator
  def validate(record)
  	current_date = Date.today
    unless BloodGlucoseLevel.where(:user_id=>record.send(:user_id)).date_range(current_date,current_date+1).count <= 4 
      record.errors[:base] << "No more than 4 entries on a given day"
    end
  end
end

class BloodGlucoseLevel < ActiveRecord::Base
	belongs_to :user
	scope :date_range, ->(start_date,end_date){where(["recorded_at >= ? and recorded_at < ?",start_date, end_date])}
	scope :min_level, ->{select("MIN(data) as min_level")}
	scope :avg_level, ->{select("AVG(data) as avg_level")}
	scope :max_level, ->{select("MAX(data) as max_level")}

	validates_with GlucoseLevelValidator


	def self.today_levels(current_usr_id)
		current_date = Date.today
		BloodGlucoseLevel.where(:user_id=>current_usr_id).date_range(current_date,current_date+1)
	end

	def self.monthly_glucose_levels(selected_dt,current_usr_id)
	  selected_date =   Date.parse(selected_dt)
      start_date =  Date.new(selected_date.year,selected_date.month)
      end_date = selected_date.end_of_month + 1
      BloodGlucoseLevel.where(:user_id=>current_usr_id).date_range(start_date,end_date)
	end

	def self.daily_glucose_levels(selected_dt,current_usr_id)
	  start_date =   Date.parse(selected_dt)
      end_date = start_date + 1
      BloodGlucoseLevel.where(:user_id=>current_usr_id).date_range(start_date,end_date)
	end

	def self.month_to_date_glucose_levels(selected_dt,current_usr_id)
	  selected_date =   Date.parse(selected_dt)
      start_date =  Date.new(selected_date.year,selected_date.month)
      end_date = selected_date + 1
      BloodGlucoseLevel.where(:user_id=>current_usr_id).date_range(start_date,end_date)
	end
end


