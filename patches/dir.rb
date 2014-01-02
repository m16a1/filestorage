class Dir
  def self.subdirs(dirname)
    entries(dirname + '/*/')
  end

  def self.files(dirname)
    entries(dirname + '/*') - subdirs(dirname)
  end
end