## Ivan Porupski(c) 23svi2024 14:22h

## PRAAT AUTOMATSKO VAĐENJE REČENICA

# Traži svaki drugi interval te ga extracta i imenuje prema filenameCounter
# Treba označit Sound i TextGrid s invervalima, Run Script
# Script bi onda trebao izbacit od 1 do n.wavs ako filenameCounter = 1
# Odabrati sljedeći Sound i TextGrid, promijenit filenameCount, Run Script.



### CODE ###

# Specify the output directory
outputDirectory$ = "C:\Users\Mr Cab Driver\Documents\A FAKS FFZG\Diplomski\Fonetika\DIPLOMSKI RAD\Govorni materijal\Audio snimke govornika GM\Obrađeno Praatom\"


# Get the IDs of the selected Sound and TextGrid
soundID = selected("Sound")
textGridID = selected("TextGrid")

# NUMBERING OF FILES HERE
# Initialize the filename counter
filenameCounter = 64


# Get the total number of intervals in the TextGrid
selectObject: textGridID
numberOfIntervals = Get number of intervals: 1


# Loop through the intervals
for i from 1 to numberOfIntervals
    # Get the label of the current interval
    selectObject: textGridID
    label$ = Get label of interval: 1, i
    
    # Check if the interval is a sentence (assuming every other interval is a sentence)
    if (i mod 2) = 0
        # Get the start and end times of the interval
        startTime = Get start time of interval: 1, i
        endTime = Get end time of interval: 1, i
        
        # Select the sound object
        selectObject: soundID
        # Extract the part of the sound corresponding to the interval
        Extract part: startTime, endTime, "rectangular", 1, "yes"
        
        # Rename the new sound object with the filename counter
        rename$ = string$(filenameCounter)
        Rename: rename$
        
        # Create the new file name
        newFileName$ = outputDirectory$ + rename$ + ".wav"
        # Save the extracted sound to a new file
        Save as WAV file: newFileName$
        
        # Increment the filename counter
        filenameCounter += 1
    endif
endfor

# Exit the script
exit




exit

# Define the names of the sound file and the TextGrid file
soundFileName$ = "govornik_1-NG.wav"
textGridFileName$ = "govornik_1-NG.TextGrid"

# Initialize the filename counter
filenameCounter = 22


# Specify the output directory
outputDirectory$ = "C:\Users\Mr Cab Driver\Documents\A FAKS FFZG\Diplomski\Fonetika\DIPLOMSKI RAD\Govorni materijal\Audio snimke govornika GM\Obrađeno Praatom\"

# Read the sound file and the TextGrid file
#Read from file: soundFileName$
#Read from file: textGridFileName$

# Select the TextGrid object by name
selectObject: "TextGrid govornik_1-NG"
# Get the total number of intervals in the TextGrid
numberOfIntervals = Get number of intervals: 1

# Loop through the intervals
for i from 1 to numberOfIntervals
    # Get the label of the current interval
    selectObject: "TextGrid govornik_1-NG"
    label$ = Get label of interval: 1, i
    
    # Check if the interval is a sentence (assuming every other interval is a sentence)
    if (i mod 2) = 0
        # Get the start and end times of the interval
        startTime = Get start time of interval: 1, i
        endTime = Get end time of interval: 1, i
        
        # Select the sound object by name
        selectObject: "Sound govornik_1-NG"
        # Extract the part of the sound corresponding to the interval
        Extract part: startTime, endTime, "rectangular", 1, "yes"
        
        # Rename the new sound object with the filename counter
        rename$ = string$(filenameCounter)
        Rename: rename$
        
        # Create the new file name
        newFileName$ = outputDirectory$ + rename$ + ".wav"
        # Save the extracted sound to a new file
        Save as WAV file: newFileName$
        
        # Increment the filename counter
        filenameCounter += 1
    endif
endfor

# Exit the script
exit

















exit

# Define the names of the sound file and the TextGrid file
#fileLocation$ = "C:\Users\Mr Cab Driver\Documents\A FAKS FFZG\Diplomski\Fonetika\DIPLOMSKI RAD\Govorni materijal\Audio snimke govornika GM\Originali\"


soundFileName$ = "govornik_1-NG.wav"
textGridFileName$ = "govornik_1-NG.TextGrid"

# Read the sound file and the TextGrid file
#Read from file: soundFileName$
#Read from file: textGridFileName$

# Select the TextGrid object by name
selectObject: "TextGrid govornik_1-NG"
# Get the total number of intervals in the TextGrid
numberOfIntervals = Get number of intervals: 1

# Initialize the filename counter
filenameCounter = 1

# Loop through the intervals
for i from 1 to numberOfIntervals
    # Get the label of the current interval
    selectObject: "TextGrid govornik_1-NG"
    label$ = Get label of interval: 1, i
    
    # Check if the interval is a sentence (assuming every other interval is a sentence)
    if (i mod 2) = 0
        # Get the start and end times of the interval
        startTime = Get start time of interval: 1, i
        endTime = Get end time of interval: 1, i
        
        # Select the sound object by name
        selectObject: "Sound govornik_1-NG"
        # Extract the part of the sound corresponding to the interval
        Extract part: startTime, endTime, "rectangular", 1, "yes"
        
        # Create the new file name
        newFileName$ = string$(filenameCounter) + ".wav"
        # Save the extracted sound to a new file
        Save as WAV file: newFileName$
        
        # Increment the filename counter
        filenameCounter += 1
    endif
endfor

# Exit the script
exit

