class EventSchedule < ActiveRecord::Base
  attr_accessible :center_id, :contact, :donation, :end_date, :event_id, :lat, :long, :notes, :start_date, :location, :course_ids
  belongs_to :center
  belongs_to :event

  validates_presence_of :center_id, :event_id, :location, :start_date, :end_date
  has_many :event_eligibilities, dependent: :delete_all
  has_many :courses, through: :event_eligibilities
  has_many :event_photos, dependent: :destroy

  scope :upcoming_events, lambda { where("start_date >= ?", Date.today).order(:start_date) }
  scope :show_on_slider, where(show_on_slider: true)

  private

  # Prepare array of upcoming events for home slider
  def self.upcoming_events_for_slider
    events = []
    show_on_slider.each do |event|
      upcoming_event_hash = {}
      upcoming_event_hash[:image] = event.event.avatar
      upcoming_event_hash[:name] = event.event.name
      upcoming_event_hash[:description] = event.event.description
      upcoming_event_hash[:id] = event.event_id
      upcoming_event_hash[:url] = Rails.application.routes.url_helpers.website_home_path(event.event_id)
      events << upcoming_event_hash
    end
    events
  end
end
