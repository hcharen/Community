json.array! @schedules do |schedule|
  json.lat schedule.latitude
  json.lng schedule.longitude
  json.title schedule.name
  json.content SchedulesController.render(partial: 'schedules/event', locals: { schedule: schedule }, format: :html).squish
end
