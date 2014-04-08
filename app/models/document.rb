class Document < ActiveRecord::Base
  belongs_to :attachable, polymorphic: true, touch: true

  has_attached_file :document, content_type: { content_type: ["application/pdf"] },
                    storage: :dropbox,
                    dropbox_credentials: "#{ Rails.root }/config/extras/dropbox.yml",
                    dropbox_options: { path: proc { |style| "#{ style }/#{ document.original_filename }" } }

  validates_attachment :document, content_type: { content_type: ["application/pdf"] }
end
