# quaqc CWL Generation Report

## quaqc

### Tool Description
Copyright (C) 2025  Benjamin Jean-Marie Tremblay

### Metadata
- **Docker Image**: quay.io/biocontainers/quaqc:1.5--h577a1d6_0
- **Homepage**: https://github.com/bjmt/quaqc
- **Package**: https://anaconda.org/channels/bioconda/packages/quaqc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/quaqc/overview
- **Total Downloads**: 1.7K
- **Last updated**: 2025-09-13
- **GitHub**: https://github.com/bjmt/quaqc
- **Stars**: N/A
### Original Help Text
```text
quaqc v1.5  Copyright (C) 2025  Benjamin Jean-Marie Tremblay

Usage:  quaqc [options] file1.bam [file2.bam [...]]

*  Recommended way to generate BAMs for quaqc during read alignment:   *
*    [bowtie2/etc  ... ]  | samtools fixmate -m -u - - \               *
*    | samtools sort -u - | samtools markdup --write-index - file.bam  *

Input options:
 -m, --mitochondria   STR   Mitochondria references names. [chrM,ChrM,Mt,MT,MtDNA,mit,Mito,mitochondria,mitochondrion]
 -p, --plastids       STR   Plastid reference names. [chrC,ChrC,Pt,PT,Pltd,Chloro,chloroplast]
 -P, --peaks          FILE  Peak coordinates in a BED file for FRIP calculation.
 -T, --tss            FILE  TSS coordinates in a BED file for TSS pileup.

Visible read options:
 -n, --target-names   STR   Only consider reads on target sequences.
 -t, --target-list    FILE  Only consider reads overlapping ranges in a BED file.
 -b, --blacklist      FILE  Only consider reads outside ranges in a BED file.
 -r, --rg-names       STR   Only consider reads with these read groups (RG).
 -R, --rg-list        FILE  Only consider reads with read groups (RG) in a file.
     --rg-tag         STR   Match reads with -r/-R using another tag, such as CB.

Filter options:
 -2, --use-secondary        Allow secondary alignments.
 -N, --use-nomate           Allow PE reads when the mate does not align properly.
 -d, --use-dups             Allow duplicate reads.
     --use-chimeric         Allow supplemental/chimeric alignments.
 -D, --use-dovetails        Allow dovetailing PE reads.
     --no-se                Discard SE reads.
 -q, --mapq           INT   Min read MAPQ score. [30]
     --min-qlen       INT   Min alignment length. [15]
     --min-flen       INT   Min fragment length. [15]
     --max-qlen       INT   Max alignment length. [250]
     --max-flen       INT   Max fragment length. [2000]
 -A, --use-all              Do not apply any filters to mapped reads.

Stat options:
     --max-depth      INT   Max base depth for read depth histogram. [100000]
     --max-qhist      INT   Max alignment length for histogram. [--max-qlen]
     --max-fhist      INT   Max fragment length for histogram. [--max-flen]
     --tss-size       INT   Size of the TSS region for pileup. [2001]
     --tss-qlen       INT   Resize reads (centered on the 5p end) for pileup. [100]
     --tss-tn5              Shift 5-prime end coordinates +4/-5 bases for pileup.
     --omit-gc              Omit calculation of read GC content.
     --omit-depth           Omit calculation of read depths.

Presets:
 -f, --fast                 --omit-gc --omit-depth (~15% shorter runtime)
     --lenient              --use-nomate --use-dups --use-dovetails --mapq=10
     --strict               --min-flen=50 --max-flen=150 --mapq=40
     --nfr                  --no-se --max-flen=120 --tss-tn5
     --nbr                  --no-se --min-flen=150 --max-flen=1000 --tss-qlen=0
     --footprint            --tss-qlen=1 --tss-size=501 --tss-tn5
     --chip                 --tss-qlen=0 --tss-size=5001 (uses --peaks for pileup)

Report options:
 -o, --output-dir     DIR   Directory to save QC report if not that of input.
 -O, --output-ext     STR   Filename extension for output files. [.quaqc.txt]
 -0, --no-output            Suppress creation of output QC reports.
 -J, --json           FILE  Save combined QC as a JSON file. Use '-' for stdout.

BAM options:
 -S, --keep                 Save passing nuclear reads in a new BAM file.
 -k, --keep-dir       DIR   Directory to create new BAM in if not that of input.
 -K, --keep-ext       STR   Extension of new BAM. [.filt.bam]

BedGraph options:
 -B, --bedGraph             Output a gzipped read density bedGraph.
     --bedGraph-qlen  INT   Resize reads (centered on the 5-prime end). [100]
     --bedGraph-tn5         Shift 5-prime end coordinates +4/-5 bases.
     --bedGraph-dir   DIR   Directory to output bedGraphs if not that of input.
     --bedGraph-ext   STR   Filename extension for bedGraphs. [.bedGraph.gz]

BED options:
 -e, --bed                  Output a gzipped BED6 file of passing reads.
     --bed-ins              Print 5-prime insertions in BED3 format instead.
     --bed-tn5              Adjust coordinates to account for Tn5 shift (+4/-5).
     --bed-dir        DIR   Directory to output BED files if not that of input.
     --bed-ext        STR   Filename extension for BED files. [.bed.gz]

Quantification options:
 -Q, --quant          FILE  Output quantification of reads in non-overlapping peaks.
     --quant-ins            Quantify based on 5-prime insertion coordinates.
     --quant-tn5            Adjust coordinates to account for Tn5 shift (+4/-5).
     --quant-pn             Use pretty names instead of full file paths.

Modify the adjustments for the various --***-tn5 options:
     --tn5-fwd        INT   Change the global Tn5 shift for forward reads. [4]
     --tn5-rev        INT   Change the global Tn5 shift for reverse reads. [5]

Program options:
 -j, --threads        INT   Number of worker threads. Max one per sample. [1]
 -i, --title          STR   Assign a title to run.
 -c, --continue             Do not stop when a sample triggers a program error.
 -v, --verbose              Print progress messages during runtime.
 -V, --version              Print the version and exit.
 -h, --help                 Print this help message.
```

