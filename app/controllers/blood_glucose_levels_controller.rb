class BloodGlucoseLevelsController < ApplicationController
  before_action :set_blood_glucose_level, only: [:show, :edit, :update, :destroy]

  # GET /blood_glucose_levels
  # GET /blood_glucose_levels.json
  def index
    @blood_glucose_level = BloodGlucoseLevel.new
    @blood_glucose_levels = BloodGlucoseLevel.today_levels(current_user.id)
  end

  # GET /blood_glucose_levels/1
  # GET /blood_glucose_levels/1.json
  def show
  end

  # GET /blood_glucose_levels/new
  def new
    @blood_glucose_level = BloodGlucoseLevel.new
  end

  # GET /blood_glucose_levels/1/edit
  def edit
  end

  # POST /blood_glucose_levels
  # POST /blood_glucose_levels.json
  def create
    @blood_glucose_level = BloodGlucoseLevel.new(blood_glucose_level_params.merge(:recorded_at => Time.zone.now,:user_id=>current_user.id))

    respond_to do |format|
      if @blood_glucose_level.save
        format.html { redirect_to root_path, notice: 'Blood glucose level was successfully created.' }
      else
       format.html { redirect_to root_path, notice: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blood_glucose_levels/1
  # PATCH/PUT /blood_glucose_levels/1.json
  def update
    respond_to do |format|
      if @blood_glucose_level.update(blood_glucose_level_params)
        format.html { redirect_to @blood_glucose_level, notice: 'Blood glucose level was successfully updated.' }
        format.json { render :show, status: :ok, location: @blood_glucose_level }
      else
        format.html { render :edit }
        format.json { render json: @blood_glucose_level.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blood_glucose_levels/1
  # DELETE /blood_glucose_levels/1.json
  def destroy
    @blood_glucose_level.destroy
    respond_to do |format|
      format.html { redirect_to blood_glucose_levels_url, notice: 'Blood glucose level was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def reports
      @blood_glucose_levels = BloodGlucoseLevel.today_levels(current_user.id)
  end

  def daily_report
      @blood_glucose_levels = BloodGlucoseLevel.daily_glucose_levels(params[:selected_date],current_user)
      respond_to do |format|
        format.js
      end
  end

  def monthly_report
      @blood_glucose_levels = BloodGlucoseLevel.monthly_glucose_levels(params[:selected_date],current_user)
      respond_to do |format|
        format.js
      end
  end

  def month_to_date_report
      @blood_glucose_levels = BloodGlucoseLevel.month_to_date_glucose_levels(params[:selected_date],current_user)
      respond_to do |format|
        format.js
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blood_glucose_level
      @blood_glucose_level = BloodGlucoseLevel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blood_glucose_level_params
      params.require(:blood_glucose_level).permit(:user, :data, :recorded_at)
    end
end
