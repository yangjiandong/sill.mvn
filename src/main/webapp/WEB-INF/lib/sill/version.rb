module Sill
  class Version
    RELEASE = 1
    MAJOR   = 0
    MINOR   = 0

    def self.to_a
      [ RELEASE, MAJOR, MINOR ]
    end

    def self.to_s
      self.to_a.join(".")
    end
  end

  class Development
    def self.to_s
      'J2ee development Ltd.'
    end
  end

  class Info
    def self.to_s
      'JROR SILL000'
    end
  end

end