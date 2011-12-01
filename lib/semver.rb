class Semver
  attr_reader :major, :minor, :patch, :pre_release, :build
  
  REGEX = /^
    (\d+)\. # major
    (\d+)\. # minor
    (\d+)   # patch
    
    # optionally add on a build or pre-release identifier
    (?:
      ([\-\+]) # build or pre_release? (+ is build, - is pre-release)
      (
        # one or more identifiers, separated by dots
        [0-9a-z][0-9a-z\-]*
        (?:\.[0-9a-z][0-9a-z\-]*)*
      )
    )?
  $/ix
  
  def initialize(ver='')
    self.version = ver
  end
  
  def version=(ver)
    m = ver.match(REGEX)
    if m
      @version     = ver
      @major       = m[1].to_i
      @minor       = m[2].to_i
      @patch       = m[3].to_i
      @pre_release = m[5] if m[4] == '-'
      @build       = m[5] if m[4] == '+'
    end
  end
  
  def version
    @version || ''
  end
  
  def bump(which)
    item = (self.send(which) + 1).to_s
    if which == :major
      version = item + '.0.0'
    elsif which == :minor
      version = @major.to_s + '.' + item + '.0'
    else
      version = @major.to_s + '.' + @minor.to_s + '.' + item
    end
    Semver.new(version)
  end
  
  def <=>(other)
    if self.major != other.major
      self.major <=> other.major
    elsif self.minor != other.minor
      self.minor <=> other.minor
    elsif self.patch != other.patch
      self.patch <=> other.patch
    end
    
    #TODO: implement build and pre-release comparison
  end
  
  def to_s
    self.version
  end
  
  def to_a
    arr = [@major, @minor, @patch]
    arr.push(@build || @pre_release) if @build || @pre_release
    arr
  end
  
end
