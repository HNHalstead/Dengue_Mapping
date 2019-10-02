
#!/bin/bash -l
#SBATCH -A snic2019-8-68
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 04:00:00
#SBATCH -J hh_BBMap_DENV
#SBATCH --mail-type=ALL
#SBATCH --mail-user halsteadholly73@gmail.com



# Load modules
module load bioinfo-tools
module load bbmap/38.61b


"try .bbmap.sh if bbmap.sh doesnt work"
bbmap.sh ref=bb.genome.fasta


"The index is written to the location /ref/"

# Next step is to map

bbmap.sh -Xmx100g threads=4 in1="$i"_1.fastq.gz in2="$i"_2.fastq.gz interleaved=true path=$db/bbmap maxindel=100k build=3 outu1="$i"_no.bb_1.fastq.gz outu2="$i"_no.bb_2.fastq.gz outm1="$i"_bb_1.fastq.gz outm2="$i"_bb_2.fastq.gz



"Now the indel settings is for humans, not sure how this will work
for bedbugs. But give it a go."

 " “outu” = unmapped reads"
" “outm” = mapped reads "

"https://jgi.doe.gov/data-and-tools/bbtools/bb-tools-user-guide/bbmap-guide/ "
"https://github.com/BioInfoTools/BBMap/blob/master/docs/UsageGuide.txt"


"You can do this as a shell script (save code below as map.away.bb.reads.sh or similar):"

for file in *_R1.fastq.gz;
    do
        name=${file##*/}
		echo $name
		base=${name%%_R1.fastq.gz}
        echo $base

        bbmap.sh -Xmx100g threads=32 in1="$base"_R1.fastq.gz in2="$base"_R2.fastq.gz interleaved=true path=$db/bbmap 	maxindel=100k build=3 outu1="$base"_no.bb_R1.fastq.gz outu2="$base"_no.bb_R2.fastq.gz outm1="$base"_bb_R1.fastq.gz outm2="$base"_bb_R2.fastq.gz

    done;
