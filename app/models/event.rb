class Event < ActiveRecord::Base
  attr_accessible :description, :event_category_id, :name, :avatar, :event_category_id
  validates_presence_of :name, :description, :event_category_id

  paperclip_options = {
      styles: {
          medium: "#{Settings.paperclip.style.medium}>",
          thumb: "#{Settings.paperclip.style.thumb}>"
      },
      :url => Settings.paperclip.image_path
  }

  has_attached_file :avatar, Paperclip::Attachment.default_options.merge(paperclip_options)
  validates_attachment_content_type :avatar, content_type:  /\Aimage\/.*\Z/

  belongs_to :event_category
end