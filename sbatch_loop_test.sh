#!/bin/bash -l
#SBATCH -A snic2019-8-68
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 00:30:00
#SBATCH -J hh_BBMap_DENV_loop_test
#SBATCH --mail-type=ALL
#SBATCH --mail-user halsteadholly73@gmail.com


for file in *fq.gz;
    do
        name=${file##*/}
		echo $name
		base=${name%%_1.fastq.gz}
        echo $base
    done;
