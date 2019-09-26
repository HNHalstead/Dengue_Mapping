# Estimating the Runtime of BBMap on <file.tar.gz>

#### look at files within
tar -tf <file.tar.gz>

#### Unzip only testing data
tar -xf <archive.tar.g> file1_F file1_R file2_F file2_R file3_F file3_R

#### Time the process of running the script on the test file and divide time by sequences

time <longrunning_command> --takeyourtime

#### divide time by number of "@" in head
#### multiply by number of reads in files
