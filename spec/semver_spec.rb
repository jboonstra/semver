require 'lib/semver'

describe Semver do
  
  describe '#initialize' do
    
    it 'should be initialized with an empty version string' do
      ver = Semver.new
      ver.version.should == ''
    end
    
    it 'should reject an invalid version string' do
      ver = Semver.new('foo')
      ver.version.should == ''
    end
    
    it 'should accept a version string on initialization' do
      v = '1.2.3'
      Semver.new(v).version.should == v
    end
    
  end
  
  describe '#version' do
    
    it 'should allow a version string to be set after initialization' do
      ver = Semver.new
      v = '1.2.3'
      ver.version = v
      ver.version.should == v
    end
    
    it 'should accept a non-dotted pre-release identifier' do
      v = '1.2.3-a1'
      ver = Semver.new(v)
      ver.version.should == v
      ver.pre_release.should == 'a1'
    end
    
    it 'should accept a pre-release identifier in dotted notation' do
      v = '1.2.3-a.b.c'
      ver = Semver.new(v)
      ver.version.should == v
      ver.pre_release.should == 'a.b.c'
    end
    
    it 'should accept a build identifier' do
      v ='1.2.3+build1'
      ver = Semver.new(v)
      ver.version.should == v
      ver.build.should == 'build1'
    end
    
    it 'should accept a build identifier in dotted notation' do
      v = '1.2.3+a.b.c'
      ver = Semver.new(v)
      ver.version.should == v
      ver.build.should == 'a.b.c'
    end
    
  end
  
  describe '#major' do
    
    it 'should report the major version number' do
      Semver.new('1.2.3').major.should == 1
    end
    
  end
  
  describe '#minor' do
    
    it 'should report the minor version number' do
      Semver.new('1.2.3').minor.should == 2
    end
    
  end
  
  describe '#patch' do
    
    it 'should report the patch number' do
      Semver.new('1.2.3').patch.should == 3
    end
    
  end
  
  describe '#bump' do
    
    it 'should be able to increment the major version number' do
      Semver.new('1.2.3').bump(:major).version.should == '2.0.0'
    end
    
    it 'should be able to increment the minor version number' do
      Semver.new('1.2.3').bump(:minor).version.should == '1.3.0'
    end
    
    it 'should be able to increment the patch version number' do
      Semver.new('1.2.3').bump(:patch).version.should == '1.2.4'
    end
    
  end
  
  describe '#to_a' do
    
    it 'should convert a version with no release or build to an array' do
      Semver.new('1.2.3').to_a.should == [1, 2, 3]
    end
    
    it 'should convert a version with a pre-release to an array' do
      Semver.new('1.2.3-a.b.c').to_a.should == [1, 2, 3, 'a.b.c']
    end
    
  end
  
  describe '#<=>' do
    
    it 'should sort major versions properly' do
      v1 = Semver.new('10.0.0')
      v2 = Semver.new('9.0.0')
      v3 = Semver.new('1.2.3')
      [v1, v2, v3].sort.should == [v3, v2, v1]
    end
    
    it 'should sort minor versions properly' do
      v1 = Semver.new('1.2.3')
      v2 = Semver.new('1.1.3')
      v3 = Semver.new('1.10.3')
      [v1, v2, v3].sort.should == [v2, v1, v3]
    end
    
    it 'should sort patch versions properly' do
      v1 = Semver.new('1.2.3')
      v2 = Semver.new('1.2.2')
      v3 = Semver.new('1.2.10')
      [v1, v2, v3].sort.should == [v2, v1, v3] 
    end
    
  end
  
end