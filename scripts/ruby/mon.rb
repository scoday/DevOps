#!/<your ruby installation location>/bin/ruby
 
#
# Include libraries used.
#
require 'open-uri'
 
#
# Data Storage files defined. These files contain
# a single number for quick processing.
#
countFile = "/<your data file location>/siteCount.txt"
UpcountFile = "/<your data file location>/UpCount.txt"
 
#
# Get the raw number of counts and increment it.
#
count = IO.readlines(countFile)[0]
count = 1 + count.to_i
IO.write(countFile,count)
 
#
# Get the number of the site being live count and
# increment it if and only if it is currently alive!
#
upcount = IO.readlines(UpcountFile)[0]
 
#
# The exception handling tells if the site is alive. If the
# site is not reachable, the "open" to read the site will
# throw an exception.
#
begin
    source = open("<your web site address>").read
    puts "Up"
    upcount = 1 + upcount.to_i
    rescue
        puts "Not up"
end
 
#
# Write the Upcount to the file.
#
IO.write(UpcountFile,upcount)
 
#
# If the upcount lags behind too much, say that the site is down.
#
if (count - upcount) > 10 then
    `/usr/bin/osascript -e 'display notification "Site is Down!"'`
end
