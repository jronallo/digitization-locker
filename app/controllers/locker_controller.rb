class LockerController < ApplicationController
  def index
    @filenames = Dir.glob(File.join(APP_CONFIG[:locker], '*'))
  end
end