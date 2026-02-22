# alignstats CWL Generation Report

## alignstats

### Tool Description
AlignStats reports various metrics for SAM, BAM, or CRAM files, including alignment statistics and coverage information.

### Metadata
- **Docker Image**: quay.io/biocontainers/alignstats:0.11--h7b50bb2_0
- **Homepage**: https://github.com/jfarek/alignstats
- **Package**: https://anaconda.org/channels/bioconda/packages/alignstats/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/alignstats/overview
- **Total Downloads**: 37.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jfarek/alignstats
- **Stars**: 20
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
AlignStats v0.11 (using HTSlib 1.21)
Usage: alignstats [-i INPUT] [-j FORMAT] [-o OUTPUT]
                  [-h] [-v] [-n NUMREADS] [-p] [-P INT]
                  [-r REGIONS] [-t TARGET] [-m COVMASK] [-T REFFASTA]
                  [-q INT] [-f INT] [-F INT] [-b INT]
                  [-D] [-M] [-O] [-U] [-A] [-C] [-W]

Runtime options:
    -h          Print usage information.
    -v          Print verbose runtime information output to stderr.
    -n INT      Maximum number of records to keep in memory.
    -p          Use separate threads for reading and processing records
                (requires builtin pthread support).
    -P INT      Number of HTSlib decompression threads to spawn.

File options:
    -i INPUT    Read INPUT as the input SAM, BAM, or CRAM file (stdin). Input
                must be coordinate-sorted for accurate results.
    -j FORMAT   Specify file format of input alignment file ("sam", "bam", or
                "cram" available, default guessed from filename or "sam").
    -o OUTPUT   Write report to OUTPUT (stdout).
    -r REGIONS  File in BED format listing which regions to process. By
                default, all available records are processed. This option
                requires the alignment file to be indexed.
    -t TARGET   File in BED format listing capture coverage regions. Required
                if capture coverage statistics are enabled.
    -m COVMASK  File in BED format listing regions of N bases in reference.
                Coverage counts will be suppressed for these regions.
    -T REFFASTA Indexed FASTA reference file for CRAM input alignment.

Processing options:
    -q INT      Only process records with minimum mapping quality of INT.
    -f INT      Only process records with all bits in INT set in FLAG.
    -F INT      Only process records with none of bits in INT set in FLAG.
    -b INT      Filter bases with base quality below INT from coverage
                statistics.

Reporting options:
    -D          Disable excluding duplicate reads from coverage statistics.
    -M          Enable excluding overlapping bases in paired-end reads by
                determining overlapping bases from MC tag.
    -O          Enable excluding overlapping bases in paired-end reads from
                first read in coordinate-sorted order from coverage statistics.
    -U          Disable processing unplaced unmapped reads (CHROM "*") when
                using the -r option.
    -A          Disable reporting alignment statistics.
    -C          Disable reporting capture coverage statistics.
    -W          Disable reporting whole genome coverage statistics.
```


## Metadata
- **Skill**: generated
