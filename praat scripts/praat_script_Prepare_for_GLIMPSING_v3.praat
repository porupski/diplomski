# Ivan Porupski (c)2024 - Alat za izradu govornog materijala (8 lip 2024)

# Praat script for preparing .wav files for GLIMPSING ANALYSIS
writeInfoLine: "PRAAT SCRIPT: GLIMPSING ANALYSIS v3.1"

# Checks for all files in InputDirectory, takes a NoiseFile and
# combines them in desired SNR (intens_sig, intens_noise)
# then saves as prename$+filename.wav into output directoy*


## Export SNR speech+mask

# BIRAJ GOVORNIKA g1-4

gov$ = "g4"

inputDirectory$ = "C:\Users\Mr Cab Driver\Documents\A FAKS FFZG\Diplomski\Fonetika\DIPLOMSKI RAD\Govorni materijal\Audio snimke govornika GM\Obrađeno 2 Audacity i Python\wav " + gov$ + " VCV/"
noiseFile$ = "C:/Users/Mr Cab Driver/Documents/A FAKS FFZG/Diplomski/Fonetika/DIPLOMSKI RAD/Govorni materijal/Audio snimke govornika GM/Obrađeno 2 Audacity i Python/SSN_" + gov$ + ".wav"
outputDirectory$ = "C:/Users/Mr Cab Driver/Documents/A FAKS FFZG/Diplomski/Fonetika/DIPLOMSKI RAD/Govorni materijal/Audio snimke govornika GM/Obrađeno 2 Audacity i Python/wav " + gov$ + " VCV mask/"

#appendInfoLine: inputDirectory$

#########

#### MANUAL SETTING HERE
##S1 = 68:70
##S2 = 68:68
##S3 = 68:66

# Sound dBSPL intensity: set to 68 dB SPL
intens_sig = 68
intens_noise = 66
prename$ = "S3"


#########

# Get the list of .wav files in the directory
Create Strings as file list... wav_files 'inputDirectory$'*.wav

# Get the number of .wav files
num_files = Get number of strings

# Print number of files found
appendInfoLine: "Number of WAV files found: ", num_files
appendInfoLine: "Signal intensity: ", intens_sig, " dbSPL"
appendInfoLine: "Noise intensity: ", intens_noise, " dbSPL"

snr = intens_sig - intens_noise

appendInfoLine: "SNR = ", snr


Read from file... 'noiseFile$'
noise_sound_name$ = selected$("Sound")
noise_id = selected("Sound")

Scale intensity: intens_noise



# Loop over each .wav file
for i from 1 to num_files

    selectObject: "Strings wav_files"
    # Get the current .wav file name
    wav_file$ = Get string... i

    # Print current file being processed
    appendInfoLine: "Processing file: ", wav_file$

    # Load the .wav file into Praat
    Read from file... 'inputDirectory$''wav_file$'
    sound_name$ = selected$("Sound")
    signal_id = selected("Sound")

    Scale intensity: intens_sig

    selectObject: signal_id
    time = Get total duration

    selectObject: noise_id
    Extract part: 0, time, "rectangular", 1, "no"
    siggy_id = selected("Sound")

    selectObject: signal_id
    plusObject: siggy_id
    comb_id = Combine to stereo
    mono_id = Convert to mono


    selectObject: mono_id

    # Print the name of the output file
    #appendInfoLine: "Saving as WAV file: ", 'outputDirectory$''prename$''wav_file$'


    # Save as WAV file
    Save as WAV file: outputDirectory$+prename$+wav_file$


    Rename: wav_file$


    # Remove the sound from Praat

    selectObject: signal_id
    plusObject: siggy_id
    plusObject: comb_id
    Remove
endfor

appendInfoLine: "Conversion complete."
