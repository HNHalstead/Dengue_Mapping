#!/bin/bash
echo "Note: This script is designed to run with the amount of memory detected by BBMap."
echo "      If Samtools crashes, please ensure you are running on the same platform as BBMap,"
echo "      or reduce Samtools' memory setting (the -m flag)."
echo "Note: Please ignore any warnings about 'EOF marker is absent'; this is a bug in samtools that occurs when using piped input."
samtools view -bShu MM16_FDMS190687288-1a_HMWVWDSXX_L3_bb.sam | samtools sort -m 17G -@ 3 - -o MM16_FDMS190687288-1a_HMWVWDSXX_L3_bb_sorted.bam
samtools index MM16_FDMS190687288-1a_HMWVWDSXX_L3_bb_sorted.bam
echo "Note: Please ignore any warnings about 'EOF marker is absent'; this is a bug in samtools that occurs when using piped input."
samtools view -bShu MM16_FDMS190687288-1a_HMWVWDSXX_L3_bb_un.sam | samtools sort -m 17G -@ 3 - -o MM16_FDMS190687288-1a_HMWVWDSXX_L3_bb_un_sorted.bam
samtools index MM16_FDMS190687288-1a_HMWVWDSXX_L3_bb_un_sorted.bam
