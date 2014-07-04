Pod::Spec.new do |spec|
  spec.name	    = 'PBFoundation'
  spec.version      = '0.0.1'
  spec.source	    = { :git => 'git://github.com/pronebird/PBFoundation' }
  spec.source_files = 'Classes/*.{h,m}'
  spec.homepage	    = 'https://github.com/pronebird/PBFoundation'
  spec.authors	    = {'Andrej Mihajlov' => 'and@codeispoetry.ru'}
  spec.description  = 'A minimalistic set of my own extensions for iOS to make apps development easier.'
  spec.license	    = 'MIT'
  spec.requires_arc = true
  spec.frameworks    = 'UIKit', 'Foundation'
  spec.platform	    = :ios, '7.0'
end
