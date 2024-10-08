## Ivan Porupski(c) 8 lip 2024 18:01h

## PRAAT AUTOMATSKO VAĐENJE REČENICA v1.1
scriptName$ = "PRAAT AUTOMATSKO VAĐENJE REČENICA v1.1" 

# Traži svaki drugi interval te ga extracta i imenuje prema filenameCounter
# Treba označit Sound i TextGrid s invervalima, Run Script
# Script bi onda trebao izbacit od 1 do n.wavs ako filenameCounter = 1
# Odabrati sljedeći Sound i TextGrid, promijenit filenameCount, Run Script.

# BIRAJ GOVORNIKA g1-4

gov$ = "g4"


### CODE ###

writeInfoLine: scriptName$

# Specify the output directory
outputDirectory$ = "C:\Users\Mr Cab Driver\Documents\A FAKS FFZG\Diplomski\Fonetika\DIPLOMSKI RAD\Govorni materijal\Audio snimke govornika GM\Obrađeno 2 Audacity i Python\wav " + gov$ + " VCV\"
appendInfoLine: "Outputting in:"
appendInfoLine: outputDirectory$


# Get the IDs of the selected Sound and TextGrid
soundID = selected("Sound")
textGridID = selected("TextGrid")

# Get the total number of intervals in the TextGrid
selectObject: textGridID
numberOfIntervals = Get number of intervals: 1

# Loop through the intervals
for i from 1 to numberOfIntervals
    # Get the label of the current interval
    selectObject: textGridID
    label$ = Get label of interval: 1, i

    # Check if label$ is a space
    if label$ = " "
        # Show error prompt
        errorMsg$ = "Error: Label is a space. Please check the TextGrid and ensure all labels are non-empty."
        appendInfoLine: errorMsg$  # Write error message to the Praat Info window
        exitScript: errorMsg$  # Exit the script with the error message
    endif
    
    # Check if the interval is a sentence (assuming every other interval is a sentence)
    if (i mod 2) = 0
        # Get the start and end times of the interval
        startTime = Get start time of interval: 1, i
        endTime = Get end time of interval: 1, i
        
        # Select the sound object
        selectObject: soundID
        # Extract the part of the sound corresponding to the interval
        Extract part: startTime, endTime, "rectangular", 1, "yes"
        
        
        # Rename the new sound object with the interval label
        Rename: label$
        
        # Create the new file name
        newFileName$ = outputDirectory$ + label$ + ".wav"
        # Save the extracted sound to a new file
        Save as WAV file: newFileName$
    endif
endfor

appendInfoLine: "Done!"

# Exit the script
exit

