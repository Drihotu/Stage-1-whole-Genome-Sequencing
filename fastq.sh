# Organize raw FASTQ reads into a dedicated folder
mkdir rawfiles
mv *.fastq.gz rawfiles/
# Quality check of raw reads 
#!/bin/bash
mkdir qc report
fastqc rawfiles/*.fastq.gz -o qcreport 
# Aggregate QC results into a single report
multiqc qcreport/ -o multiqc_report      
