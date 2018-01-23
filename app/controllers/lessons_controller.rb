class LessonsController < ApplicationController

  respond_to :json

  def get_lessons
    @lessons = current_user.lessons
    lessons = []
    @lessons.each do |lesson|
      lessons << {:id => lesson.id }
    end
    render :text => lessonss.to_json
  end

 def index
   @lessons = Lesson.where(start: params[:start]..params[:end])
 end

 def show
 end

 def new
   @lesson = Lesson.new
 end

 def edit
 end

 def create
   @lesson = Lesson.new(lesson_params)
   @lesson.save
 end

 def update
   @lesson.update(lesson_params)
 end

 def destroy
   @lesson.destroy
 end

  private

  def lesson_params
    params.require(:lesson).permit(:client_id, :location_id, :horse_id, horse_attributes: [:name], location_attributes: [:name], client_attributes: [:name], lesson_time: [:date, :hour, :min], duration: [:hour, :min])
  end
end
