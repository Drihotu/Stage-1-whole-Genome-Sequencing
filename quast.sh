#!/bin/bash
mkdir -p quast_results

# Loop through each assembled sample
for sample in assembly/*; do
    if [ -f "$sample/contigs.fasta" ]; then
        sample_name=$(basename "$sample")
        echo "Running QUAST on $sample_name ..."
        quast.py "$sample/contigs.fasta" -o "quast_results/${sample_name}"
    fi
done
