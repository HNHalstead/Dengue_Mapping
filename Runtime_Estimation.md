# Estimating the Runtime of BBMap on <file.tar.gz>

### 1. look at files within
###### _Verify that the file was uploaded correctly as well as see the format of contained files_

```
tar -tf <file.tar.gz>
```
<br>

#### 2. Unzip only testing data
```
tar -xf <archive.tar.g> file1_F file1_R file2_F file2_R file3_F file3_R
```
<br>

#### 3. Time the process of running the script on the test file and divide time by sequences

```
time <longrunning_command> --takeyourtime
```

#### 4 .Multiply by the number of sequence runs in tar.gz file
#### 5. Run <longrunning_command> using the same amount of nodes as was used in the test run for when you submit a job.
