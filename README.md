# FastQFixer
A simple Bash script to make FASTQ read names unique by appending an incrementing numeric suffix. This is useful when merging FASTQ data from multiple sequencing runs where read names may collide, causing problems for downstream tools such as GATK BaseRecalibrator, MarkDuplicates, or ApplyBQSR.

## Features
- Works on FASTQ files (`*.fastq.gz`)
- Preserves sequences and quality values
- Adds a unique suffix to each read name (e.g., `_1`, `_2`, `_3`…)
- Useful for resolving read-name collisions after run merging

## Workflow

When sequencing the same sample across multiple runs, read names can collide when files are merged. To avoid this, follow the BELOW workflow:

1. Merge FASTQ files from multiple runs:

```bash
cat run1_R1.fastq.gz run2_R1.fastq.gz run3_R1.fastq.gz > merged_R1.fastq.gz
cat run1_R2.fastq.gz run2_R2.fastq.gz run3_R2.fastq.gz > merged_R2.fastq.gz
```

2. Rename the reads:
```bash
./FastQFixer.sh  merged_R1.fastq.gz  merged_fixed_R1
./FastQFixer.sh  merged_R2.fastq.gz  merged_fixed_R2
```
