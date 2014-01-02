class Dir
  def self.subdirs(dirname)
    glob(dirname.chomp('/') + '/*/')
  end

  def self.files(dirname)
    glob(dirname.chomp('/') + '/*') - subdirs(dirname)
  end
end