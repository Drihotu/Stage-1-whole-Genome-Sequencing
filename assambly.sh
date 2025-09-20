#!/bin/bash
mkdir assembly

for R1 in qc_reads/*_1.fastq.gz; do
    R2="${R1/_1.fastq.gz/_2.fastq.gz}"
    SAMPLE="${R1%%_*}"
    echo "Assembling sample: $SAMPLE"
    spades.py \
      -1 "$R1" \                              
      -2 "$R2" \                                 
      -o "/assembly/${SAMPLE}" \                  
      --phred-offset 33                           # Phred encoding quality score
done
