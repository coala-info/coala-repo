# recycler CWL Generation Report

## recycler_make_fasta_from_fastg.py

### Tool Description
make_fasta_from_fastg converts fastg assembly graph to fasta format

### Metadata
- **Docker Image**: quay.io/biocontainers/recycler:0.7--py27h24bf2e0_2
- **Homepage**: https://github.com/Shamir-Lab/Recycler
- **Package**: https://anaconda.org/channels/bioconda/packages/recycler/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/recycler/overview
- **Total Downloads**: 20.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Shamir-Lab/Recycler
- **Stars**: N/A
### Original Help Text
```text
usage: make_fasta_from_fastg.py [-h] -g GRAPH [-o OUTPUT]

make_fasta_from_fastg converts fastg assembly graph to fasta format

optional arguments:
  -h, --help            show this help message and exit
  -g GRAPH, --graph GRAPH
                        (spades 3.50+) FASTG file to process [recommended:
                        before_rr.fastg]
  -o OUTPUT, --output OUTPUT
                        output file name for FASTA of cycles
```


## recycler_samtools

### Tool Description
Tools for alignments in the SAM format

### Metadata
- **Docker Image**: quay.io/biocontainers/recycler:0.7--py27h24bf2e0_2
- **Homepage**: https://github.com/Shamir-Lab/Recycler
- **Package**: https://anaconda.org/channels/bioconda/packages/recycler/overview
- **Validation**: PASS

### Original Help Text
```text
Program: samtools (Tools for alignments in the SAM format)
Version: 1.8 (using htslib 1.8)

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
     targetcut      cut fosmid regions (for fosmid pool only)
     addreplacerg   adds or replaces RG tags
     markdup        mark duplicates

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


## recycler_recycle.py

### Tool Description
Recycler extracts likely plasmids (and other circular DNA elements) from de novo assembly graphs

### Metadata
- **Docker Image**: quay.io/biocontainers/recycler:0.7--py27h24bf2e0_2
- **Homepage**: https://github.com/Shamir-Lab/Recycler
- **Package**: https://anaconda.org/channels/bioconda/packages/recycler/overview
- **Validation**: PASS

### Original Help Text
```text
usage: recycle.py [-h] -g GRAPH -k MAX_K -b BAM [-l LENGTH] [-m MAX_CV]
                  [-i ISO] [-o OUTPUT_DIR]

Recycler extracts likely plasmids (and other circular DNA elements) from de
novo assembly graphs

optional arguments:
  -h, --help            show this help message and exit
  -g GRAPH, --graph GRAPH
                        (spades 3.50+) assembly graph FASTG file to process;
                        recommended for spades 3.5: before_rr.fastg, for
                        spades 3.6+:assembly_graph.fastg
  -k MAX_K, --max_k MAX_K
                        integer reflecting maximum k value used by the
                        assembler
  -b BAM, --bam BAM     BAM file resulting from aligning reads to contigs
                        file, filtering for best matches
  -l LENGTH, --length LENGTH
                        minimum length required for reporting [default: 1000]
  -m MAX_CV, --max_CV MAX_CV
                        coefficient of variation used for pre-selection
                        [default: 0.5, higher--> less restrictive]
  -i ISO, --iso ISO     True or False value reflecting whether data sequenced
                        was an isolated strain
  -o OUTPUT_DIR, --output_dir OUTPUT_DIR
                        Output directory
```


## Metadata
- **Skill**: generated
