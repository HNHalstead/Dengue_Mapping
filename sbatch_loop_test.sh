#!/bin/bash -l
#SBATCH -A snic2019-8-68
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 00:30:00
#SBATCH -J hh_BBMap_DENV_loop_test
#SBATCH --mail-type=ALL
#SBATCH --mail-user halsteadholly73@gmail.com


tar -tf H201SC19071015_20190905_X201SC19071015-Z01-F001_YJfd4B.tar.gz | for file in '*fq.gz';
    do
        name=${file##*/}
		echo $name >> loop_test.txt
		base=${name%%_1.fastq.gz}
        echo $base >> loop_test.txt
    done;
