module Locker
  class Filepath
    attr_accessor :filepath
    
    def initialize(filepath)
      @filepath = filepath
    end
  
    def repository_image_path
      File.join(repository_path, File.basename(filepath) )
    end
    
    def repository_path
      filename_to_ppath(APP_CONFIG[:repository_pairtree])
    end
    
    def access_path
      filename_to_ppath(APP_CONFIG[:access_pairtree])
    end
    
    def access_image_path
      File.join(access_path, basename + ".#{APP_CONFIG[:access_image_format]}")
    end
    
    
  
    def filename_to_ppath(pairtree)
      bname = basename
      File.expand_path(File.join(pairtree,
      Orchard::Pairtree.id_to_ppath(bname) ) )
    end
      
    def full_ppath(pairtree)
      original_basename = File.basename(filepath)
      
      pairtree_path = filename_to_ppath(pairtree)
      FileUtils.mkdir_p(pairtree_path)
      File.join(pairtree_path, original_basename)
    end
    
    def cp_to_ptree(pairtree)
      full_pairtree_path = full_ppath(pairtree)
      FileUtils.cp(filepath, full_pairtree_path)
    end
    
    def create_access_copy
      image = MiniMagick::Image.open(filepath)
      image.resize APP_CONFIG[:access_image_size]
      image.format APP_CONFIG[:access_image_format]
      FileUtils.mkdir_p(access_path)
      image.write access_image_path
    end
    
    def basename
      extname = File.extname(filepath)
      File.basename(filepath, extname)
    end
    
  end
    
end