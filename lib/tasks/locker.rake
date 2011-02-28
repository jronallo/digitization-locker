namespace :locker do
  
  desc 'watch the locker space and move stable files'
  task :watch => :environment do
    dw = DirectoryWatcher.new(APP_CONFIG[:locker])
    dw.stable = APP_CONFIG[:stable_interval]
    dw.persist = APP_CONFIG[:watcher_persist]
    # pp dw
    dw.add_observer do |*args|
      args.each do |event|
        # puts event.inspect
        if event.type == :stable
          FileUtils.mv(event.path, File.join(APP_CONFIG[:tank], '.'))
        end
      end
    end
    dw.load!
    dw.run_once
    dw.persist!
  end
  
  desc 'process the holding tank files'
  task :process => :environment do
    Dir.glob(File.join(APP_CONFIG[:tank], '*')).each do |file_path|
      lf = Locker::Filepath.new(file_path)
      lf.cp_to_ptree(APP_CONFIG[:repository_pairtree])
      r = Resource.new
      r.filename = File.basename(file_path)
      lf.create_access_copy
      # convert into access copies
      if File.exists?(lf.filename_to_ppath(APP_CONFIG[:repository_pairtree]))
        FileUtils.rm(file_path)
      else
        # do something with this kind of error
      end
      # extract title
      r.title = r.extract_title!
      r.save
      Sunspot.commit
    end
  end
  
  
end