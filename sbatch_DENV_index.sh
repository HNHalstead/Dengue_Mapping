#!/bin/bash -l
#SBATCH -A snic2019-8-68
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 05:00:00
#SBATCH -J hh_index_DENV_1.sterr
#SBATCH -o hh_index_DENV_1.stdout
#SBATCH --mail-type=ALL
#SBATCH --mail-user halsteadholly73@gmail.com

module load bioinfo-tools
module load samtools/1.9

for file in /crex/proj/snic2019-8-68/proj_holly/Dengue_bwa/*.bam;
do
  samtools index -b $file
  echo "$file has been indexed"
done
