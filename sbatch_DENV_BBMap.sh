#!/bin/bash -l
#SBATCH -A snic2019-8-68
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 20:00:00
#SBATCH -J hh_BBMap_DENV_run1
#SBATCH --mail-type=ALL
#SBATCH --mail-user halsteadholly73@gmail.com



# Load modules
module load bioinfo-tools
module load bbmap/38.61b


# try .bbmap.sh if bbmap.sh doesnt work"
#bbmap.sh ref=bb.genome.fasta
##### bbmap.sh ref=Denv1_cn_ref.fasta

# The index is written to the location /ref/

# Next step is to map

# bbmap.sh threads=4 in1="$i"_1.fastq.gz in2="$i"_2.fastq.gz interleaved=true path=$db/bbmap maxindel=20k build=3 outu1="$i"_no.bb_1.fastq.gz outu2="$i"_no.bb_2.fastq.gz outm1="$i"_bb_1.fastq.gz outm2="$i"_bb_2.fastq.gz

## threads changed to 4 from 32 as 32 was over-kill
## maxindel reduced from 100k to 20k as Dengue isn't that large
## -Xmx100g not needed with Uppmax

#“outu” = unmapped reads
#“outm” = mapped reads




#You can do this as a shell script (save code below as map.away.bb.reads.sh or similar):
PROJ_DIR=$PWD
cd $SNIC_TMP #unzips into temp file which saves time on the network
for file in $(tar xvzf H201SC19071015_20190905_X201SC19071015-Z01-F001_YJfd4B.tar.gz | grep "_1.fq.gz");
do
    #name=$(basename "$file") #${file##*/}
    prefix=$(basename "$file" _1.fq.gz )
    #echo $name >> long_loop_test_if.txt
    #if [[ ${file} ~ "2.fq.gz$" ]];
    #then
      #base=${name%%_2.fq.gz}
      #echo $base >> long_loop_test_if.txt
      #echo "if worked" >> long_loop_test_if.txt
    #bbmap.sh ref=$PROJ_DIR/Denv1_cn_ref.fasta threads=${SLURM_NPROCS} \
    #in1="$base"_1.fq.gz \
    #  in2="$base"_2.fq.gz interleaved=true maxindel=20k build=3 \
    #  outu1="$base"_bb_R1.fastq.gz outu2="$base"_bb_R2.fastq.gz \
    #  outm1="$base"_bb_R1.fastq.gz outm2="$base"_bb_R2.fastq.gz
    bbmap.sh ref="$PROJ_DIR/Denv1_cn_ref.fasta" threads="${SLURM_NPROCS}" \
      in1="$file" in2="${file/_1.fq.gz/_2.fq.gz}" interleaved=true maxindel=20k build=3 \
      outu1="${prefix}_bb_R1.fastq.gz" outu2="${prefix}_bb_R2.fastq.gz" \
      outm1="${prefix}_bb_R1.fastq.gz" outm2="${prefix}_bb_R2.fastq.gz"
    #fi
    #continue
done
cp "${prefix}_bb_R1.fastq.gz" "${prefix}_bb_R2.fastq.gz" "${prefix}_bb_R1.fastq.gz" "${prefix}_bb_R2.fastq.gz" $PROJ_DIR/

# mahesh.panchal@nbis.se
