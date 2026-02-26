# whokaryote CWL Generation Report

## whokaryote_whokaryote.py

### Tool Description
Classify metagenomic contigs as eukaryotic or prokaryotic

### Metadata
- **Docker Image**: quay.io/biocontainers/whokaryote:1.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/LottePronk/whokaryote
- **Package**: https://anaconda.org/channels/bioconda/packages/whokaryote/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/whokaryote/overview
- **Total Downloads**: 7.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/LottePronk/whokaryote
- **Stars**: N/A
### Original Help Text
```text
usage: whokaryote.py [-h] [--contigs CONTIGS] [--outdir OUTDIR] [--gff GFF]
                     [--f] [--test] [--train TRAIN] [--minsize MINSIZE]
                     [--model MODEL] [--threads THREADS]

Classify metagenomic contigs as eukaryotic or prokaryotic

optional arguments:
  -h, --help         show this help message and exit
  --contigs CONTIGS  The path to your contigs file. It should be one
                     (multi)fasta (DNA).
  --outdir OUTDIR    Specify the path to your preferred output directory. No /
                     at the end.
  --gff GFF          If you already have gene predictions, specify path to the
                     .gff file
  --f                If you want new multifastas with only eukaryotes and only
                     prokaryotes.
  --test             If you want to test it on a known dataset.
  --train TRAIN      For training an RF on your own dataset. Provide name of
                     RF output file.
  --minsize MINSIZE  Select a minimum contig size in bp, default = 5000.
                     Accuracy on contigs below 5000 is lower.
  --model MODEL      Choose the stand-alone model or the tiara-integrated
                     model: S or T. Option 'T' only works with argument
                     --contigs
  --threads THREADS  Number of threads for Tiara to use.
```

