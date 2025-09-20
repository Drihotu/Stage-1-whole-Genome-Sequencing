## Data trimming 
#!/bin/bash
mkdir -p qc_reads

# Loop through paired-end FASTQ files and run FASTP for trimming
for R1 in rawfiles/*_1.fastq.gz; do
    R2="${R1/_1.fastq.gz/_2.fastq.gz}"
    SAMPLE=$(basename "$R1" | cut -d'_' -f1)
    echo "Processing sample: $SAMPLE"
    fastp \
      -i "$R1" \                            
      -I "$R2" \                                  
      -o "qc_reads/${SAMPLE}_1.fastq.gz" \       
      -O "qc_reads/${SAMPLE}_2.fastq.gz" \  
      --html "qc_reads/${SAMPLE}_fastp.html"     
done
