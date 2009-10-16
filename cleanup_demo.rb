require 'cleanup'
require 'cleanup_test'

mymod = Modset.new("sample.txt")
mymod.about
mymod.makemods("def","deaf")
# mymod.makemods("self","yesitsme")
mymod.about

