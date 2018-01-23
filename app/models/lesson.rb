class Lesson < ApplicationRecord
  belongs_to :location
  belongs_to :user
  belongs_to :client
  belongs_to :horse

  accepts_nested_attributes_for :client
  accepts_nested_attributes_for :location
  accepts_nested_attributes_for :horse

  def start_time
    self.lesson_time
  end

  def end_time
    lesson_time + duration.seconds
  end

  def client_name
    client.name
  end

  def location_name
    location.nickname if location
  end

  ## Form Parsing methods

  def client_attributes=(atts)
    if atts[:name] != ""
      self.client = self.user.clients.find_or_create_by(atts)
    end
  end

  def location_attributes=(atts)
    if atts[:nickname] != ""
      location = self.user.locations.find_or_create_by(atts)
      self.location = location
    end
  end

  def lesson_time=(time)
    if time.is_a?(Hash)
      self[:lesson_time] = parse_datetime(time)
    else
      self[:lesson_time] = time
    end
  end

  def parse_date(string)
    array = string.split("/")
    first_item = array.pop
    array.unshift(first_item).join("-")
  end

  def parse_datetime(hash)
    if hash["date"].match(/\d{2}\/\d{2}\/\d{4}/)
      Time.zone.parse("#{parse_date(hash["date"])} #{hash["hour"]}:#{hash["min"]}")
    end
  end

  def duration=(duration)
    if duration.is_a?(Hash)
      self[:duration] = parse_duration(duration)
    else
      self[:duration] = duration
    end
  end

  def parse_duration(hash)
    hash["hour"].to_i + hash["min"].to_i
  end

  ## Validations

  validates :duration, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :lesson_time, presence: { message: "must be a valid date" }
  validates :horse_id, presence: true
  validates :client_id, presence: true

  validate :time_still_valid

  def time_still_valid
    LessonTimeValidator.new(self).validate
  end

  include ActiveModel::Validations

  class LessonTimeValidator
    def initialize(lesson)
      @lesson = lesson
      @user = lesson.user
    end

    def validate
      if @lesson.lesson_time
        # selects the user's lessons from yesterday,
        # today and tomorrow
        lessons = @user.lessons.select { |a| a.lesson_time.midnight == @lesson.lesson_time.midnight || a.lesson_time.midnight == @lesson.lesson_time - 1.day || a.lesson_time.midnight == @lesson.lesson_time + 1.day }
        # makes sure that current lessons don't overlap
        # first checks if an existing lesson is still
        # in progress when the new lesson is set to start
        # next checks if the new lesson would still be in
        # progress when an existing lesson is set to start
        lessons.each do |lesson|
          if @lesson != lesson
            if lesson.lesson_time <= @lesson.lesson_time && @lesson.lesson_time <= lesson.end_time || @lesson.lesson_time <= lesson.lesson_time && lesson.lesson_time <= @lesson.end_time
              @lesson.errors.add(:lesson_time, "is not available.")
            end
          end
        end
      end

    end

  end

  validate do |lesson|
    LessonTimeValidator.new(lesson).validate
  end
end
