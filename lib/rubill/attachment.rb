require 'base64'

module Rubill
  class Attachment < Base
    def self.send_attachment(object_id, file_name, content)
      Query.upload_attachment({
        data: {
          id: object_id,
          fileName: file_name,
          document: ensure_base64(content)
        }
      })
    end

    def self.ensure_base64(content)
      if content =~ /\A[A-Za-z0-9]+={0,3}\Z/ && content.size % 4 == 0
        content
      else
        Base64.strict_encode64(content)
      end
    end

    def self.remote_class_name
      "Attachment"
    end
  end
end
