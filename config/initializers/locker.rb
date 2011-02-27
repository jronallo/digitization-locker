[:locker, :tank].each do |key|
  Dir.mkdir(APP_CONFIG[key]) unless File.exists?(APP_CONFIG[key])
end
