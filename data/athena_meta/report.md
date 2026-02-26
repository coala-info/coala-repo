# athena_meta CWL Generation Report

## athena_meta_athena-meta

### Tool Description
Athena Meta: A pipeline for assembling metagenomes

### Metadata
- **Docker Image**: quay.io/biocontainers/athena_meta:1.3--py27_0
- **Homepage**: https://github.com/abishara/athena_meta/
- **Package**: https://anaconda.org/channels/bioconda/packages/athena_meta/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/athena_meta/overview
- **Total Downloads**: 10.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/abishara/athena_meta
- **Stars**: N/A
### Original Help Text
```text
usage: athena-meta [-h] [--config CONFIG] [--check_prereqs] [--test]
                   [--force_reads] [--threads THREADS]

optional arguments:
  -h, --help         show this help message and exit
  --config CONFIG    input JSON config file for run, NOTE:
                     dirname(config.json) specifies root output directory
  --check_prereqs    test if external deps visible in environment
  --test             run tiny assembly test to check setup and prereqs
  --force_reads      proceed with subassembly even if input *bam and *fastq do
                     not pass QC
  --threads THREADS  number of multiprocessing threads
```


## athena_meta_bwa

### Tool Description
alignment via Burrows-Wheeler transformation

### Metadata
- **Docker Image**: quay.io/biocontainers/athena_meta:1.3--py27_0
- **Homepage**: https://github.com/abishara/athena_meta/
- **Package**: https://anaconda.org/channels/bioconda/packages/athena_meta/overview
- **Validation**: PASS

### Original Help Text
```text
Program: bwa (alignment via Burrows-Wheeler transformation)
Version: 0.7.17-r1188
Contact: Heng Li <lh3@sanger.ac.uk>

Usage:   bwa <command> [options]

Command: index         index sequences in the FASTA format
         mem           BWA-MEM algorithm
         fastmap       identify super-maximal exact matches
         pemerge       merge overlapping paired ends (EXPERIMENTAL)
         aln           gapped/ungapped alignment
         samse         generate alignment (single ended)
         sampe         generate alignment (paired ended)
         bwasw         BWA-SW for long queries

         shm           manage indices in shared memory
         fa2pac        convert FASTA to PAC format
         pac2bwt       generate BWT from PAC
         pac2bwtgen    alternative algorithm for generating BWT
         bwtupdate     update .bwt to the new format
         bwt2sa        generate SA from BWT and Occ

Note: To use BWA, you need to first index the genome with `bwa index'.
      There are three alignment algorithms in BWA: `mem', `bwasw', and
      `aln/samse/sampe'. If you are not sure which to use, try `bwa mem'
      first. Please `man ./bwa.1' for the manual.
```


## athena_meta_samtools

### Tool Description
Tools for alignments in the SAM format

### Metadata
- **Docker Image**: quay.io/biocontainers/athena_meta:1.3--py27_0
- **Homepage**: https://github.com/abishara/athena_meta/
- **Package**: https://anaconda.org/channels/bioconda/packages/athena_meta/overview
- **Validation**: PASS

### Original Help Text
```text
Program: samtools (Tools for alignments in the SAM format)
Version: 1.9 (using htslib 1.9)

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

