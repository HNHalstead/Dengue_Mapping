#!/bin/bash -l
#SBATCH -A snic2019-8-68
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 25:00:00
#SBATCH -J hh_map_DENV_bwa
#SBATCH --mail-type=ALL
#SBATCH --mail-user halsteadholly73@gmail.com

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

for file in $(tar xvzf /crex/proj/snic2019-8-68/proj_holly/H201SC19071015_20190905_X201SC19071015-Z01-F001_YJfd4B.tar.gz | grep "_1.fq.gz");
do
  echo "prefix=$(basename "$file" _1.fq.gz )
    bwa index -p "${prefix}" /crex/proj/snic2019-8-68/proj_holly/Denv1_cn_ref.fasta
    bwa mem -M "${prefix}" "$file" "${file/_1.fq.gz/_2.fq.gz}" | samtools sort -o ${prefix}_sorted.bam"

  prefix=$(basename "$file" _1.fq.gz )
  bwa index -p "${prefix}" /crex/proj/snic2019-8-68/proj_holly/Denv1_cn_ref.fasta
  bwa mem -M "${prefix}" "$file" "${file/_1.fq.gz/_2.fq.gz}" | samtools sort -o ${prefix}_sorted.bam

  echo "mv ${prefix}_sorted.bam* $PROJ_DIR/Dengue_bwa/"
  mv ${prefix}_sorted.bam* $PROJ_DIR/Dengue_bwa/



done

# Load modules
module load bioinfo-tools
module load samtools/1.9
