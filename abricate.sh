#!/bin/bash
mkdir -p AMR_test VFDB_test AMR_test/summary VFDB_test/summary

# Loop through assemblies 
for asm in $(find assembly/*/contigs.fasta | head -10); do
    sample=$(basename $(dirname "$asm"))
    echo "Processing $sample"

    # AMR gene identification using CARD database
    abricate --db card "$asm" > AMR_test/${sample}_amr.tab

    # Virulence gene identification using VFDB
    abricate --db vfdb "$asm" > VFDB_test/${sample}_vfdb.tab
done

echo "Generating summary tables using abricate --summary"

# Generate summary reports for AMR and virulence profiles
abricate --summary AMR_test/*.tab > AMR_test/summary/amr_summary.tsv
abricate --summary VFDB_test/*.tab > VFDB_test/summary/vfdb_summary.tsv

echo "Done! Summary tables created:"
echo "  - AMR (CARD): AMR_test/summary/amr_summary.tsv"
echo "  - Virulence (VFDB): VFDB_test/summary/vfdb_summary.tsv"
