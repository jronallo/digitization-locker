class TankController < ApplicationController
  def index
    @filenames = Dir.glob(File.join(APP_CONFIG[:tank], '*'))
  end
end