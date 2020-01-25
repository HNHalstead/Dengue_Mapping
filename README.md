# **Dengue_Mapping**
### _Made for the Purpose of Mapping Back Dengue Reads of different serovars to a reference_

<br/>
<br/>

###### Import tar zipped sequence files to *UPPMAX* and change the code within the file sbatch_DENV_bwa.sh as indicated
_*Time may need to be adjusted based on the number of files to map_

```
#!/bin/bash -l
#SBATCH -A <project_code>
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 25:00:00
#SBATCH -J <file_tag>
#SBATCH --mail-type=ALL
#SBATCH --mail-user <your_email>

###Mapping RNA for Dengue

# Load modules
module load bioinfo-tools
module load bwa/0.7.17
module load samtools/1.9
# Your commands

#Index reference genome as it is large
#Map RNA from Serum to genome assembly
PROJ_DIR=$PWD
echo $PWD

mkdir Dengue_bwa
echo "Dengue_bwa dir made"

cd $SNIC_TMP #unzips into temp file which saves time on the network

for file in $(tar xvzf <path/to/file.tar.gz> | grep "<file_tag_for_forward_reads.fq.gz>");
do
  echo "prefix=$(basename "$file" <file_tag_for_forward_reads.fq.gz> )
    bwa index -p "${prefix}" <path/to/reference_file.fasta>
    bwa mem -M "${prefix}" "$file" "${file/<file_tag_for_forward_reads.fq.gz>/<file_tag_for_reverse_reads.fq.gz>}" | samtools sort -o ${prefix}_sorted.bam
    samtools index $BAM"

  prefix=$(basename "$file" <file_tag_for_forward_reads.fq.gz> )
  bwa index -p "${prefix}" <path/to/reference_file.fasta>
  bwa mem -M "${prefix}" "$file" "${file/<file_tag_for_forward_reads.fq.gz>/<file_tag_for_reverse_reads.fq.gz>}" | samtools sort -o ${prefix}_sorted.bam


  echo "mv ${prefix}_sorted.bam* $PROJ_DIR/Dengue_bwa/"
  mv ${prefix}_sorted.bam* $PROJ_DIR/Dengue_bwa/

done

module load bioinfo-tools
module load samtools/1.9

for BAM in <directory/path/Dengue_bwa/*.bam>;
do
  samtools index -b $BAM
  echo "$BAM has been indexed"
done
```
<br/>
<br/>

###### The script can then be added to the queue to run from the project directory using the command
```
sbatch sbatch_DENV_bwa.sh
```
<br/>
<br/>

###### When all files should be processed, there should be a .bam and a .bam.bai file for each set of files processed. These can then be viewed immediately by running the following commands to open up the IGV (Integrated Genome Viewer) GUI:
```
module load java bioinfo-tools IGV
igv-node
```

<br/>
<br/>


### Troubleshooting
###### Indexing can be done separately using the command
```
sbatch sbatch_DENV_index.sh
```
