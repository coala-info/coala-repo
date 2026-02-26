# viral-ngs CWL Generation Report

## viral-ngs_samtools

### Tool Description
Tools for alignments in the SAM format

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/broadinstitute/viral-ngs
- **Stars**: N/A
### Original Help Text
```text
Program: samtools (Tools for alignments in the SAM format)
Version: 1.3.1 (using htslib 1.3.1)

Usage:   samtools <command> [options]

Commands:
  -- Indexing
     dict           create a sequence dictionary file
     faidx          index/extract FASTA
     index          index alignment

  -- Editing
     calmd          recalculate MD/NM tags and '=' bases
     fixmate        fix mate information
     reheader       replace BAM header
     rmdup          remove PCR duplicates
     targetcut      cut fosmid regions (for fosmid pool only)
     addreplacerg   adds or replaces RG tags

  -- File operations
     collate        shuffle and group alignments by name
     cat            concatenate BAMs
     merge          merge sorted alignments
     mpileup        multi-way pileup
     sort           sort alignment file
     split          splits a file by read group
     quickcheck     quickly check if SAM/BAM/CRAM file appears intact
     fastq          converts a BAM to a FASTQ
     fasta          converts a BAM to a FASTA

  -- Statistics
     bedcov         read depth per BED region
     depth          compute the depth
     flagstat       simple stats
     idxstats       BAM index stats
     phase          phase heterozygotes
     stats          generate stats (former bamcheck)

  -- Viewing
     flags          explain BAM flags
     tview          text alignment viewer
     view           SAM<->BAM<->CRAM conversion
     depad          convert padded BAM to unpadded BAM
```

