class Resource < ActiveRecord::Base
  attr_accessible :filename, :title
  
  searchable do
    text :title
    text :filename
  end
  
  def access_image
    # FIXME:
    File.join(APP_CONFIG[:access_pairtree].sub('public',''),
      Orchard::Pairtree.id_to_ppath(basename),
      basename + ".#{APP_CONFIG[:access_image_format]}" )
  end
  
  def extract_title!
    begin
      mead = new_mead
      if mead.valid?
        mead.extract
        @title = mead.metadata.map do |c|
          c.unittitle + ', ' + c.unitdate
        end.join(' :: ')
      end
    rescue
      basename.split('_').join(' ').split('-').join(' ')
    end
  end
  
  def basename
    Locker::Filepath.new(filename).basename
  end
  
  def new_mead
    Mead::Identifier.new(Locker::Filepath.new(filename).basename,
      APP_CONFIG[:ead_url])
  end
end
