[:locker, :tank, :repository_pairtree, :access_pairtree].each do |key|
  FileUtils.mkdir_p(APP_CONFIG[key]) unless File.exists?(APP_CONFIG[key])
end
