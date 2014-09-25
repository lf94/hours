-- Read in an hours file and print the total hours.
-- Hours file format:
-- Desc\tDate\tStartTime-EndTime\n
import System.Environment
import Data.List.Split

-- Return milliseconds
get_milliseconds :: [String] -> Double
get_milliseconds xs = hours + minutes
	where
		hours = (read (xs !! 0) :: Double) * 60 * 60 * 1000
		minutes = (read (xs !! 1) :: Double) * 60 * 1000

-- Time format: HH:MM (24H)
time_difference :: String -> String -> Double
time_difference start end = (end_milli - start_milli) / 1000.0 / 60.0 / 60.0
	where
		start_milli = get_milliseconds (splitOn ":" start)
		end_milli = get_milliseconds (splitOn ":" end)

-- Recursively get every line, split it up, and figure out the total
get_hours :: [String] -> [Double]
get_hours xs = 
	[ (time_difference start end) 
		| x <- xs, 
		let military_time = splitOn " " ((splitOn "\t" x) !! 2),  
		let start = military_time !! 0, 
		let end = military_time !! 2 
	]

-- Determine if a line is not a comment
not_comment :: String -> Bool
not_comment str
	| str !! 0 == '/' && str !! 1 == '/' = False
	| otherwise = True

main = do
	args <- getArgs
	content <- readFile (args !! 0)
	let linesOfFiles = lines content
	let hours =  get_hours (filter not_comment linesOfFiles)
	mapM_ print hours
	print (sum hours)