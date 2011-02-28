class Resource < ActiveRecord::Base
  attr_accessible :filename, :title
  
  def access_image
    basename = Locker::Filepath.new(filename).basename
    # FIXME:
    File.join(APP_CONFIG[:access_pairtree].sub('public',''),
      Orchard::Pairtree.id_to_ppath(basename),
      basename + ".#{APP_CONFIG[:access_image_format]}" )
  end
  
  def extract_title!
    mead = new_mead
    if mead.valid?
      mead.extract
      @title = mead.metadata.map do |c|
        c.unittitle + ', ' + c.unitdate
      end.join(' :: ')
    end
  end
  
  def new_mead
    Mead::Identifier.new(Locker::Filepath.new(filename).basename,
      APP_CONFIG[:ead_url])
  end
end
