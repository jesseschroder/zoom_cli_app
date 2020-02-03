# frozen_string_literal: true
class VideoGame < BaseModel
  def assign_platform(platform)
    (@platform ||= []).push(platform)
    self.class.public_send(:attr_reader, :platform) unless respond_to?(:platform)
  end
end
