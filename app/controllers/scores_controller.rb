class ScoresController < ApplicationController
  def index
    @scores = Score.all
  end

  def new
    require_login
    @score = Score.new
  end

  def create
    require_login
    @score = Score.new(score_params)
    @score.user_id = current_user.id
    if @score.save
      redirect_to score_path(@score)
    else
      render :new
    end
  end

  def show
    require_login
    gon.scores = Score.find(params[:id])
    @score = Score.find(params[:id])
  end

  def analyze
    require_login
    @score = Score.find(params[:id])
    gon.pitch_range_data = Score.get_ranges
    gon.melodic_contour = @score.get_frequencies
    # gon.data1 = Score.find(params[:id]).get_range
  end

  def search
    @results = Score.search(params[:search])

    redirect_to score_path(@results[0]) if @results.length == 1
  end

  def destroy
    require_login
    @score = Score.find(params[:id])
    @score.destroy

    redirect_to user_path(current_user)
  end


  private

  def score_params
    params.require(:score).permit(:user_id, :title, :composer, :music_xml, :sound_clip, :music_xml)
  end




end
