class Semver
  
  REGEX = /^v(\d+)\.(\d+)\.(\d+)([a-z][0-9a-z]*)?$/i
  
  def initialize(ver='')
    self.version = ver
  end
  
  def version=(ver)
    @version = ver if ver.match(REGEX)
  end
  
  def version
    @version || ''
  end
  
  def to_s
    self.version
  end
  
end
