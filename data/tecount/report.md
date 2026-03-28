# tecount CWL Generation Report

## tecount_TEcount

### Tool Description
Count reads mapping on Transposable Elements subfamilies, families and classes.

### Metadata
- **Docker Image**: quay.io/biocontainers/tecount:1.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/bodegalab/tecount
- **Package**: https://anaconda.org/channels/bioconda/packages/tecount/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tecount/overview
- **Total Downloads**: 7.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bodegalab/tecount
- **Stars**: N/A
### Original Help Text
```text
usage: TEcount -b <file.bam> -r <rmsk.bed.gz> [OPTIONS]

Count reads mapping on Transposable Elements subfamilies, families and
classes.

options:
  -h, --help            show this help message and exit
  -b BAM, --bam BAM     scRNA-seq reads aligned to a reference genome
  -r RMSK, --rmsk RMSK  Genomic TE coordinates in bed format, with subfamily,
                        family and class on columns 7, 8 and 9. Plain text or
                        gzip-compressed.
  -o OVERLAP, --overlap OVERLAP
                        Minimum bp overlap between read and feature (default:
                        1).
  -s STRANDNESS, --strandness STRANDNESS
                        Strandness of the library. One of: "unstranded"
                        (default), "forward", "reverse".
  --prefix PREFIX       Prefix for output file names (default: no prefix).
  --outdir OUTDIR       Output directory (default: current directory).
  --tmpdir TMPDIR       Temporary files directory (default: ./tmp).
  --keeptmp             Keep temporary files (default: False).
  -p THREADS, --threads THREADS
                        Number of cpus to use (default: 1)
  -V, --version         Print software version and quit.

Documentation and issue tracker: https://github.com/bodegalab/tecount
```


## tecount_samtools

### Tool Description
Tools for alignments in the SAM format

### Metadata
- **Docker Image**: quay.io/biocontainers/tecount:1.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/bodegalab/tecount
- **Package**: https://anaconda.org/channels/bioconda/packages/tecount/overview
- **Validation**: PASS

### Original Help Text
```text
Program: samtools (Tools for alignments in the SAM format)
Version: 1.16.1 (using htslib 1.16)

Usage:   samtools <command> [options]

Commands:
  -- Indexing
     dict           create a sequence dictionary file
     faidx          index/extract FASTA
     fqidx          index/extract FASTQ
     index          index alignment

  -- Editing
     calmd          recalculate MD/NM tags and '=' bases
     fixmate        fix mate information
     reheader       replace BAM header
     targetcut      cut fosmid regions (for fosmid pool only)
     addreplacerg   adds or replaces RG tags
     markdup        mark duplicates
     ampliconclip   clip oligos from the end of reads

  -- File operations
     collate        shuffle and group alignments by name
     cat            concatenate BAMs
     consensus      produce a consensus Pileup/FASTA/FASTQ
     merge          merge sorted alignments
     mpileup        multi-way pileup
     sort           sort alignment file
     split          splits a file by read group
     quickcheck     quickly check if SAM/BAM/CRAM file appears intact
     fastq          converts a BAM to a FASTQ
     fasta          converts a BAM to a FASTA
     import         Converts FASTA or FASTQ files to SAM/BAM/CRAM
     reference      Generates a reference from aligned data

  -- Statistics
     bedcov         read depth per BED region
     coverage       alignment depth and percent coverage
     depth          compute the depth
     flagstat       simple stats
     idxstats       BAM index stats
     phase          phase heterozygotes
     stats          generate stats (former bamcheck)
     ampliconstats  generate amplicon specific stats

  -- Viewing
     flags          explain BAM flags
     head           header viewer
     tview          text alignment viewer
     view           SAM<->BAM<->CRAM conversion
     depad          convert padded BAM to unpadded BAM
     samples        list the samples in a set of SAM/BAM/CRAM files

  -- Misc
     help [cmd]     display this help message or help for [cmd]
     version        detailed version information
```


## Metadata
- **Skill**: generated
