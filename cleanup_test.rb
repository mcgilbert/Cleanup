require "test/unit"
require "cleanup"
load 'cleanup.rb'

class TestCleanup < Test::Unit::TestCase

  def test_setup
    # create a file for testing
    # setup variables and instances
    
    filename="sample.txt"
    searchstring="def"
    replacestring="deaf"
    mymod = Modset.new(filename)
    searchstringcount=mymod.originalfile.readlines.to_s.split(searchstring).size
    mymod.makemods(searchstring,replacestring)
    replacestringcount=mymod.currentfile.readlines.to_s.split(replacestring).size
    
    # assertions
    
    # 1. Modset creation requires an original filename
    assert_raise (ArgumentError) {Modset.new()} 
    
    # 2. Replaced file doesn't contain the search string
    assert(mymod.currentfile.readlines.include?("def") == false)
    
    #3. The count of the original string should match the count on the replacement string
    assert(searchstringcount==replacestringcount)
    
  end
  
end

# To Do:
# (1) restrict replacements to particular columns
# (2) ability to work from command line (interactive? menu?)
# (3) summary of changes as returned result (how many? anything else?)
# (4) some ability to view results (perhaps long form of return - changed elements compared, listed) - pipe to more
# (5) account for column headers (and perhaps row headers)
# (6) help from the command line
# (7) only give a count of what will happen if the replacement is run
# (8) run line by line (or element by element) in interactive mode
# (9) add result summaries to log file
# (10) undo
# (11) is there a reason to save diffs?



