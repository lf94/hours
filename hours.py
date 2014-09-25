# Read in an hours file and print the total hours.
# Hours file format:
# Desc\tDate\tStartTime-EndTime
import sys

# Time format: HH:MM (24H)
def time_difference(start, end):
	end = end.split(":")
	start = start.split(":")
	end_milli = int(end[0])*60*60*1000
	end_milli += int(end[1])*60*1000
	start_milli = int(start[0])*60*60*1000
	start_milli += int(start[1])*60*1000
	diff = end_milli - start_milli
	diff = diff / 1000 / 60 / 60 
	return diff	


with open(sys.argv[1]) as fh:
	lines = fh.readlines()

total = 0.0

for line in lines:
	if(line[0] == '/' and line[1] == '/'):
		continue
	data = line.split("\t")
	time = data[2].split(" ")	
	diff = time_difference(time[0], time[2]) #time[1] is a hyphen(-)
	print(diff)
	total += diff

print(total)
