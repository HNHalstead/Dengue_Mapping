#!/bin/bash -l
#SBATCH -A snic2019-8-68
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 30:00:00
#SBATCH -J hh_BBMap_DENV_run2
#SBATCH --mail-type=ALL
#SBATCH --mail-user halsteadholly73@gmail.com



# Load modules
module load bioinfo-tools
module load bbmap/38.61b
module load samtools/1.9


# try .bbmap.sh if bbmap.sh doesnt work"
#bbmap.sh ref=bb.genome.fasta
##### bbmap.sh ref=Denv1_cn_ref.fasta

# The index is written to the location /ref/

# Next step is to map

# bbmap.sh threads=4 in1="$i"_1.fastq.gz in2="$i"_2.fastq.gz interleaved=true path=$db/bbmap maxindel=20k build=3 outu1="$i"_no.bb_1.fastq.gz outu2="$i"_no.bb_2.fastq.gz outm1="$i"_bb_1.fastq.gz outm2="$i"_bb_2.fastq.gz

## threads changed to 4 from 32 as 32 was over-kill
## maxindel reduced from 100k to default of 16k as Dengue isn't that large
## -Xmx100g not needed with Uppmax

#“outu” = unmapped reads
#“outm” = mapped reads




#You can do this as a shell script (save code below as map.away.bb.reads.sh or similar):
mkdir Mapped_Files
PROJ_DIR=$PWD
cd $SNIC_TMP #unzips into temp file which saves time on the network
for file in $(tar xvzf /crex/proj/snic2019-8-68/proj_holly/H201SC19071015_20190905_X201SC19071015-Z01-F001_YJfd4B.tar.gz | grep "_1.fq.gz");
do

    prefix=$(basename "$file" _1.fq.gz )
    bbmap.sh ref="$PROJ_DIR/Denv1_cn_ref.fasta" threads="${SLURM_NPROCS}" \
      in1="$file" in2="${file/_1.fq.gz/_2.fq.gz}" build=3 \
      outu1="${prefix}_bb_R1.sam" outu2="${prefix}_bb_R2.sam" \
      outm1="${prefix}_bb_R1.sam" outm2="${prefix}_bb_R2.sam"
      for SAM in *.sam;
      do
        pre=$(basename "$SAM" .sam)
        samtools view -S -b "${pre}.sam" > "${pre}.bam"
      done
      cp "${prefix}_bb_R1.bam" "${prefix}_bb_R2.bam" "${prefix}_bb_R1.bam" "${prefix}_bb_R2.fastq.bam" $PROJ_DIR/Mapped_Files/
done


#module load bioinfo-tools
#module load samtools/1.9
#PROJ_DIR=$PWD
#for bam in $PROJ_DIR/*bam;
#do
#  samtools sort $bam
#  echo "$bam sorted" >> samtools_check.txt
#done

# mahesh.panchal@nbis.se
