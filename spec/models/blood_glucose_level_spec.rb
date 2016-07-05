require 'rails_helper'

RSpec.describe BloodGlucoseLevel, type: :model do

  before do
    
    @user1 = FactoryGirl.create(:user,:name => "xyz",:role_id=>1,:email => "sss@gmail.com",:password=>"1234567")
    @user2 = FactoryGirl.create(:user,:name => "pqr",:role_id=>1,:email => "ggg@gmail.com",:password=>"1234568")

    FactoryGirl.create(:blood_glucose_level, :user_id => @user1.id,:data => 44, :recorded_at => DateTime.new(2016,7,4,8,0,0))
    FactoryGirl.create(:blood_glucose_level, :user_id => @user1.id,:data => 50, :recorded_at => DateTime.new(2016,7,4,13,0,0))
    FactoryGirl.create(:blood_glucose_level, :user_id => @user1.id,:data => 30, :recorded_at => DateTime.new(2016,7,4,17,0,0))
    FactoryGirl.create(:blood_glucose_level, :user_id => @user1.id,:data => 60, :recorded_at => DateTime.new(2016,7,4,22,0,0))

    FactoryGirl.create(:blood_glucose_level, :user_id => @user2.id,:data => 44, :recorded_at => DateTime.new(2016,7,2,8,0,0))
    FactoryGirl.create(:blood_glucose_level, :user_id => @user2.id,:data => 50, :recorded_at => DateTime.new(2016,7,2,13,0,0))

    FactoryGirl.create(:blood_glucose_level, :user_id => @user2.id,:data => 44, :recorded_at => DateTime.new(2016,7,4,8,0,0))
    FactoryGirl.create(:blood_glucose_level, :user_id => @user2.id,:data => 50, :recorded_at => DateTime.new(2016,7,4,15,0,0))

    FactoryGirl.create(:blood_glucose_level, :user_id => @user2.id,:data => 44, :recorded_at => DateTime.now)
    FactoryGirl.create(:blood_glucose_level, :user_id => @user2.id,:data => 50, :recorded_at => DateTime.now)
    FactoryGirl.create(:blood_glucose_level, :user_id => @user2.id,:data => 44, :recorded_at => DateTime.now)

  end

 context "No more than 4 entries on a given day" do
    it "expect false with extra entry" do
      gl_level = BloodGlucoseLevel.new(:user_id=>@user1.id,:data=>60,:recorded_at => DateTime.new(2016,7,4,23,0,0))
      expect(gl_level.save).to eq(false)
    end
  end

  context "Making entry in blood glucose level" do
    it "expect object if success" do
      gl_level = BloodGlucoseLevel.new(:user_id=>@user2.id,:data=>60,:recorded_at => DateTime.new(2016,7,5,20,0,0))
      expect(gl_level.save).not_to eq(nil)
    end
  end

  context "A user should be able to view reports of their data" do
  	it "Daily report" do
      blood_glucose_levels = BloodGlucoseLevel.daily_glucose_levels('2016-7-4',@user1.id)
      expect(blood_glucose_levels.count).to eq(4)
  	end

  	it "Month to date report" do
      blood_glucose_levels = BloodGlucoseLevel.month_to_date_glucose_levels('2016-7-4',@user2.id)
      expect(blood_glucose_levels.count).to eq(4)
  	end

  	it "Monthly report" do
      blood_glucose_levels = BloodGlucoseLevel.monthly_glucose_levels('2016-7-1',@user2.id)
      expect(blood_glucose_levels.count).to eq(5)
  	end

    it "Today report" do
      blood_glucose_levels = BloodGlucoseLevel.today_levels(@user2.id)
      expect(blood_glucose_levels.count).to eq(3)
    end

  end


end
