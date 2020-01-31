class VideoGame < BaseModel

  def assign_platform(platform)
    @platform = platform
    self.class.public_send(:attr_reader, :platform)
  end
end
