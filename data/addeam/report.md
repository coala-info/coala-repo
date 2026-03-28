# addeam CWL Generation Report

## addeam_samtools

### Tool Description
Tools for alignments in the SAM format

### Metadata
- **Docker Image**: quay.io/biocontainers/addeam:1.0.0--py313h1510ab2_0
- **Homepage**: https://github.com/LouisPwr/AdDeam
- **Package**: https://anaconda.org/channels/bioconda/packages/addeam/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/addeam/overview
- **Total Downloads**: 260
- **Last updated**: 2025-07-14
- **GitHub**: https://github.com/LouisPwr/AdDeam
- **Stars**: N/A
### Original Help Text
```text
Program: samtools (Tools for alignments in the SAM format)
Version: 1.22 (using htslib 1.22)

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
     reset          Reverts aligner changes in reads

  -- Statistics
     bedcov         read depth per BED region
     coverage       alignment depth and percent coverage
     depth          compute the depth
     flagstat       simple stats
     idxstats       BAM index stats
     cram-size      list CRAM Content-ID and Data-Series sizes
     phase          phase heterozygotes
     stats          generate stats (former bamcheck)
     ampliconstats  generate amplicon specific stats
     checksum       produce order-agnostic checksums of sequence content

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


## addeam_addeam-bam2prof.py

### Tool Description
Python wrapper for bam2prof

### Metadata
- **Docker Image**: quay.io/biocontainers/addeam:1.0.0--py313h1510ab2_0
- **Homepage**: https://github.com/LouisPwr/AdDeam
- **Package**: https://anaconda.org/channels/bioconda/packages/addeam/overview
- **Validation**: PASS

### Original Help Text
```text
usage: addeam-bam2prof.py [-h] [-minq MINQ] [-minl MINL] [-endo ENDO]
                          [-length LENGTH] [-err ERR] [-log] [-bed BED]
                          [-mask MASK] [-paired] [-meta] [-classic]
                          [-precision PRECISION] [-minAligned MINALIGNED]
                          [-ref-id REF_ID] [-single] [-double] [-both] [-o O]
                          [-dp] [-q {0,1}] [-threads THREADS] [-hpc HPC]
                          [-bam2profpath BAM2PROFPATH]
                          [-minConverge MINCONVERGE]
                          [-stepsConverge STEPSCONVERGE]
                          [bam_files]

Python wrapper for bam2prof

positional arguments:
  bam_files             File with paths to BAM files; one per line.

options:
  -h, --help            show this help message and exit
  -minq MINQ            Minimum base quality (default: 0)
  -minl MINL            Minimum fragment/read length (default: 35)
  -endo ENDO            Endo flag (default: 0)
  -length LENGTH        Length (default: 5)
  -err ERR              Error rate (default: 0)
  -log                  Logarithmic scale (default: False)
  -bed BED              BED file for positions
  -mask MASK            BED file for mask positions
  -paired               Allow paired reads (default: False)
  -meta                 One Profile per unique reference (default: False)
  -classic              One Profile per bam file (default: False)
  -precision PRECISION  Set minimum decimal precision for substitution
                        frequency computation (default: 0 [= all alignments
                        used]). Increase speed by setting to either (from
                        faster to slower): 0.01, 0.001, ... )
  -minAligned MINALIGNED
                        Number of aligned sequences after which substitution
                        patterns are checked if frequencies converge (default:
                        10000000)
  -ref-id REF_ID        Specify reference ID
  -single               Single strand library (default: False)
  -double               Double strand library (default: False)
  -both                 Report both C->T and G->A (default: False)
  -o O                  Output directory
  -dp                   Output in damage-patterns format (default: False)
  -q {0,1}              Do not print why reads are skipped (default: 1)
  -threads THREADS      Number of threads. One file per thread (default: 1)
  -hpc HPC              Dry Run. Pipe execution commands to file
  -bam2profpath BAM2PROFPATH
                        Provide absolute path to bam2prof binary and use it
                        for execution
  -minConverge MINCONVERGE
                        Set minimum threshold for substitution frequency
                        convergence (default: 0.01)
  -stepsConverge STEPSCONVERGE
                        Check every step-size number of aligned fragments for
                        convergence (default: 500)
```


## addeam_addeam-cluster.py

### Tool Description
Cluster and plot damage profiles.

### Metadata
- **Docker Image**: quay.io/biocontainers/addeam:1.0.0--py313h1510ab2_0
- **Homepage**: https://github.com/LouisPwr/AdDeam
- **Package**: https://anaconda.org/channels/bioconda/packages/addeam/overview
- **Validation**: PASS

### Original Help Text
```text
usage: addeam-cluster.py [-h] -i INPUT_DIR -o OUTPUT_DIR [-k CLUSTERS]
                         [-q LESS PLOTS (FASTER)] [-m MINIMUM MAPPED READS]
                         [-plotall PLOT ALL PROFS]
                         [-lib {single,paired,mixed}]

Cluster and plot damage profiles.

options:
  -h, --help            show this help message and exit
  -i INPUT_DIR          Path to the directory containing the profiles
                        generated with bam2prof.
  -o OUTPUT_DIR         Path where your plots will be saved.
  -k CLUSTERS           Run clustering from 2 to k. (default: 4)
  -q LESS PLOTS (FASTER)
                        Do not plot probability per sample. Write to TSV only.
                        [off=0,on=1](default: 0)
  -m MINIMUM MAPPED READS
                        Require at least m reads to be mapped to a reference
                        to be included in clustering (default: 1000)
  -plotall PLOT ALL PROFS
                        Set to 1 if all profs should be plotted individually.
                        Slow! (default: 0)
  -lib {single,paired,mixed}
                        Type of library reads in your input BAMs. (default:
                        paired)
```


## Metadata
- **Skill**: generated
