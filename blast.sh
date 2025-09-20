#!/bin/bash
ASSEMBLY_DIR="./assembly"
BLAST_DIR="./blast"
mkdir -p "$BLAST_DIR"

REPRESENTATIVE_ASSEMBLY=$(find "$ASSEMBLY_DIR" -name "contigs.fasta" | head -1)

if [[ -z "$REPRESENTATIVE_ASSEMBLY" ]]; then
    echo "Error: No assemblies found. Run assembly script first."
    exit 1
fi

SAMPLE_NAME=$(basename $(dirname "$REPRESENTATIVE_ASSEMBLY"))
echo "Using representative sample: $SAMPLE_NAME"

# first contig for BLAST
head -n 200 "$REPRESENTATIVE_ASSEMBLY" > "$BLAST_DIR/representative_contig.fasta"

echo "Running BLAST against NCBI nt database (this may take a few minutes)..."
blastn \
    -query "$BLAST_DIR/representative_contig.fasta" \
    -db nt \
    -remote \
    -outfmt "6 std stitle" \
    -max_target_seqs 5 \
    -evalue 1e-50 \
    -out "$BLAST_DIR/blast_identification_results.tsv"

echo "BLAST complete. Top hits:"
echo "----------------------------------------"
awk -F'\t' '{printf "%-60s %-6s %-6s %-10s\n", $13, $3, $4, $11}' "$BLAST_DIR/blast_identification_results.tsv" | head -5
echo "------
