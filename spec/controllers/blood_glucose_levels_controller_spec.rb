require 'rails_helper'

RSpec.describe BloodGlucoseLevelsController, type: :controller do


	describe "GET index" do
		it "assigns @blood_glucose_levels" do
      		blood_glucose_level = BloodGlucoseLevel.create
      		get :index
      		expect(assigns(:blood_glucose_levels)).to eq([blood_glucose_level])
    	end

    	it "renders the index template" do
      		get :index
      		expect(response).to render_template("index")
    	end

	end

	describe "GET reports" do
		it "assigns @blood_glucose_levels" do
      		blood_glucose_level = BloodGlucoseLevel.create
      		get :reports
      		expect(assigns(:blood_glucose_levels)).to eq([blood_glucose_level])
    	end

    	it "renders the reports template" do
      		get :reports
      		expect(response).to render_template("reports")
    	end

	end

    
end
