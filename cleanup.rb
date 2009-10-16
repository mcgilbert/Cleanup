# A script to support the cleanup of data tables for research analysis
# Allows iterative search and replace, both throughout and within a column, 
# the display of the data between iterations to permit identification of further cleanup,
# and a history of cleaned up file versions, with info on what the transformation was

# Homework: create a class, an instance of it
# a method that inspects the instances (about)
# do ONE thing (agile progress)

# Possible objects: dataset, column, modification, modificationhistory

# lets start with no spreadsheet module
# and with a single column text file, with no header


# main class takes a text file name as an argument
# assume same directory for version saving
# ask for first search string and first replacement string
# execute the search and replace
# display results
# offer undo option
# offer save version and stop
# offer save version and continue
# save the version, named properly, and log changes
# repeat until stop

class Modset
  
  attr_accessor :originalfile, :logfile, :modnum, :currentfile
  
  def initialize(filename)
    @filename = filename
    @originalfile = File.new(@filename)
    @currentfile = @originalfile
    @logfile = File.new("#{@filename}.log", "w+")
    @modnum = 0
  end #def initialize
  
  def about
    
    # instead of overriding the inspect method
    puts "Set up to modify #{@originalfile.path}. #{@modnum} modifications so far."
    puts "For modification history see #{@logfile.path}."
    
  end
  
  def makemods(searchfor, replacewith, replaceincolumn="all") 
    
    # increment the file name, create a new file
    @modnum += 1
    @replacementfile = File.new("#{@filename}-#{@modnum}", "w+")
    
    # write each line of the current file to the new file, replacing strings as we go
    # this is restricted to a particular column unless replaceincolumn is "all"
    begin 
      if replaceincolumn == "all"
        @currentfile.each { |lineofdata| @replacementfile << lineofdata.gsub(searchfor, replacewith) }
      else  
        @currentfile.each { |lineofdata| @replacementfile << lineofdata.split("\t")[replaceincolumn].gsub(searchfor, replacewith) }
      end
    rescue => err 
      puts err 
    end
        
    # write to the log file, update current file
    @logfile << "#{@replacementfile.path}\t#{@currentfile.path}\t#{searchfor}\t#{replacewith}\t#{replaceincolumn}\n"
    @currentfile = @replacementfile.dup
    
  end #def makemods
  
end #class Modset


