#!/bin/bash -l
#SBATCH -A snic2019-8-68
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 40:00:00
#SBATCH -o hh_BBMap_DENV_run6.stdout
#SBATCH -e hh_BBMap_DENV_run6.stderr
#SBATCH -J hh_BBMap_DENV_run6
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
PROJ_DIR=$PWD
echo $PWD
cd $SNIC_TMP #unzips into temp file which saves time on the network
for file in $(tar xvzf /crex/proj/snic2019-8-68/proj_holly/H201SC19071015_20190905_X201SC19071015-Z01-F001_YJfd4B.tar.gz | grep "_1.fq.gz");
do

    prefix=$(basename "$file" _1.fq.gz )
    echo 'ref="$PROJ_DIR/Denv1_cn_ref.fasta" threads="${SLURM_NPROCS}" \
      in1="$file" in2="${file/_1.fq.gz/_2.fq.gz}" build=3 \
      outu="${prefix}_bb_un.sam" \
      outm="${prefix}_bb.sam" \
      bs=$PROJ_DIR/Dengue_Mapping/sam2bam.sh; sh sam2bam.sh
      echo "${prefix} bam files created" >> bam_file_tracking.txt'


    bbmap.sh ref="$PROJ_DIR/Denv1_cn_ref.fasta" threads="${SLURM_NPROCS}" \
      in1="$file" in2="${file/_1.fq.gz/_2.fq.gz}" build=3 \
      out="${prefix}_bb.sam"
      #outu="${prefix}_bb_un.sam" \
      #outm="${prefix}_bb.sam"

      module load bioinfo-tools
      module load samtools/1.9

      echo "Note: Please ignore any warnings about 'EOF marker is absent'; this is a bug in samtools that occurs when using piped input."
      samtools view -bShu "${prefix}_bb.sam" | samtools sort -o "${prefix}_bb.sam"_bb_sorted.bam
      samtools index "${prefix}_bb.sam"_bb_sorted.bam

      #b for bam file, h to include header in output, u for uncompressed bam \
      # as it is being piped, S ignored compatability with previous samtools versions



      #$PROJ_DIR/Dengue_Mapping/sam2bam.sh "${prefix}_bb.sam"
      #$PROJ_DIR/Dengue_Mapping/sam2bam.sh "${prefix}_bb_un.sam"

      mkdir $PROJ_DIR/Mapped_Files
      cp "${prefix}_bb_sorted.bam" $PROJ_DIR/Mapped_Files
      #cp "${prefix}_bb_un.bam" $PROJ_DIR/Mapped_Files/
      cp "${prefix}_bb_sorted.bam.bai" $PROJ_DIR/Mapped_Files
      #cp "${prefix}_bb_un.bam.bai" $PROJ_DIR/Mapped_Files/


      #cp "${prefix}_bb_R1.bam" "${prefix}_bb_R2.bam" "${prefix}_bb_un_R1.bam" "${prefix}_bb_un_R2.fastq.bam" $PROJ_DIR/Mapped_Files/
      #cp "${prefix}_bb_R1.bam.bai" "${prefix}_bb_R2.bam.bai" "${prefix}_bb_un_R1.bam.bai" "${prefix}_bb_un_R2.bam.bai" $PROJ_DIR/Mapped_Files/
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
