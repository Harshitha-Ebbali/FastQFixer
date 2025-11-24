#!/bin/bash

# Usage:
# ./fix_fastq_single.sh input.fastq.gz output_prefix
# Output: output_prefix.fastq.gz

IN=$1
OUT=$2

if [[ -z "$IN" || -z "$OUT" ]]; then
    echo "Usage: $0 input.fastq.gz output_prefix"
    exit 1
fi

TMP="${OUT}.tmp.fastq"
> $TMP

zcat "$IN" | awk -v OUTTMP="$TMP" '
NR % 4 == 1 {
    # Header line
    count++
    split($0, fields, " ")
    main = fields[1]
    rest = ""

    # Reconstruct the part after the main read name (if any)
    for (i = 2; i <= NF; i++) {
        rest = rest " " fields[i]
    }

    # Remove @ from beginning, add unique suffix, then rebuild full header
    sub(/^@/, "", main)
    print "@" main "_" count rest >> OUTTMP
    next
}

# Sequence, +, quality lines stay unchanged
{
    print >> OUTTMP
}
'

gzip -f "$TMP"
mv "${OUT}.tmp.fastq.gz" "${OUT}.fastq.gz"

echo "Done!"
echo "Generated: ${OUT}.fastq.gz"

