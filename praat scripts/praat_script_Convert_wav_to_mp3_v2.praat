# Ivan Porupski (c)2024 - Alat za izradu govornog materijala

# Praat script that takes in n amount of speech material as .wav from (InputDirectory),
# a noise mask (NoiseFile) to be processed and saved as .mp3 in (OutputDirectory) 
# Sets intensity for both signal and noise (so you can set custom SNR)
# Adds 500ms of silence to each speech material (beginning and end) and masks it with noise.
# Outputs as .mp3 files. Also listed in Praat Objects.


# Define the directory containing the .wav files and the output directory for MP3 files
form Convert WAV to MP3
    sentence InputDirectory C:\Users\Mr Cab Driver\Documents\A FAKS FFZG\Diplomski\Fonetika\DIPLOMSKI RAD\Govorni materijal\Audio snimke govornika GM\Obrađeno 2 Audacity i Python\Normalized 23LUFS - Audacity\g1\
    sentence NoiseFile C:\Users\Mr Cab Driver\Documents\A FAKS FFZG\Diplomski\Fonetika\DIPLOMSKI RAD\Govorni materijal\Audio snimke govornika GM\Obrađeno 2 Audacity i Python\SSN_g1.wav
    sentence OutputDirectory C:\Users\Mr Cab Driver\Documents\A FAKS FFZG\Diplomski\Fonetika\DIPLOMSKI RAD\Govorni materijal\Audio snimke govornika GM\Obrađeno 2 Audacity i Python\mp3 g1\
endform

# Sound dBSPL intensity: set to 68 dB SPL
intens_sig = 68
intens_noise = 70

prename$ = "S1"


Read from file... 'NoiseFile$'
noise_sound_name$ = selected$("Sound")
noise_id = selected("Sound")

Scale intensity: intens_noise

# Extract 500ms of silence
Extract part: 0, 0.5, "rectangular", 1, "no"
silence_id = selected("Sound")

Set part to zero: 0, 0, "at nearest zero crossing"


# Get the list of .wav files in the directory
Create Strings as file list... wav_files 'InputDirectory$'*.wav

# Get the number of .wav files
num_files = Get number of strings

# Print number of files found
writeInfoLine: "Number of WAV files found: ", num_files
appendInfoLine: "Signal intensity: ", intens_sig, " dbSPL"
appendInfoLine: "Noise intensity: ", intens_noise, " dbSPL"

snr = intens_sig - intens_noise

appendInfoLine: "SNR = ", snr

fade_duration = 0.1

appendInfoLine: "Fade duration: ", fade_duration, " s"



# Loop over each .wav file
for i from 1 to num_files

    selectObject: "Strings wav_files"
    # Get the current .wav file name
    wav_file$ = Get string... i

    # Print current file being processed
    appendInfoLine: "Processing file: ", wav_file$

    # Load the .wav file into Praat
    Read from file... 'InputDirectory$''wav_file$'
    sound_name$ = selected$("Sound")
    signal_id = selected("Sound")

    Scale intensity: intens_sig

    selectObject: signal_id
    time = Get total duration
    time = time + 1

    selectObject: noise_id
    Extract part: 0, time, "rectangular", 1, "no"
    siggy_id = selected("Sound")

    selectObject: silence_id
    plusObject: signal_id
    con_id = Concatenate
    plusObject: siggy_id
    comb_id = Combine to stereo
    mono_id = Convert to mono




    #selectObject: mono_id
    #time2 = Get total duration
    #fade_samples = fade_duration * Get sampling frequency




    selectObject: mono_id
    # Define the output .mp3 file name
    mp3_file$ = replace$(wav_file$, ".wav", ".mp3", 0)

    # Print the name of the output file
    #appendInfoLine: "Saving as MP3 file: ", 'OutputDirectory$''mp3_file$'

    # Save as highest quality MP3 file
    Save as highest quality MP3 file... 'OutputDirectory$''prename$''mp3_file$'

    Rename: mp3_file$

    # Remove the sound from Praat

    selectObject: signal_id
    plusObject: siggy_id
    plusObject: con_id
    plusObject: comb_id
    Remove
endfor

appendInfoLine: "Conversion complete."
