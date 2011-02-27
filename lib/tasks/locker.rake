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
  
  
end