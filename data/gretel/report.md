# gretel CWL Generation Report

## gretel

### Tool Description
Gretel: A metagenomic haplotyper.

### Metadata
- **Docker Image**: quay.io/biocontainers/gretel:0.0.94--pyh864c0ab_1
- **Homepage**: https://github.com/SamStudio8/gretel
- **Package**: https://anaconda.org/channels/bioconda/packages/gretel/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gretel/overview
- **Total Downloads**: 20.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/SamStudio8/gretel
- **Stars**: N/A
### Original Help Text
```text
usage: gretel [-h] [-s START] [-e END] [-p PATHS] [--master MASTER]
              [--gapchar GAPCHAR] [--delchar DELCHAR] [--quiet] [-o OUT]
              [-@ THREADS] [--debugreads DEBUGREADS] [--debugpos DEBUGPOS]
              [--debughpos DEBUGHPOS] [--dumpmatrix DUMPMATRIX]
              [--dumpsnps DUMPSNPS] [--pepper] [--version]
              bam vcf contig

Gretel: A metagenomic haplotyper.

positional arguments:
  bam
  vcf
  contig

optional arguments:
  -h, --help            show this help message and exit
  -s START, --start START
                        1-indexed included start base position [default: 1]
  -e END, --end END     1-indexed inlcuded end base position [default:
                        reference length]
  -p PATHS, --paths PATHS
                        Maximum number of paths to generate [default:100]
  --master MASTER       Master sequence (will be used to fill in homogeneous
                        gaps in haplotypes, otherwise --gapchar)
  --gapchar GAPCHAR     Character to fill homogeneous gaps in haplotypes if no
                        --master [default N]
  --delchar DELCHAR     Character to output in haplotype for deletion (eg. -)
                        [default is blank]
  --quiet               Don't output anything other than a single summary
                        line.
  -o OUT, --out OUT     Output directory [default .]
  -@ THREADS, --threads THREADS
                        Number of BAM iterators [default 1]
  --debugreads DEBUGREADS
                        A newline delimited list of read names to output debug
                        data when parsing the BAM
  --debugpos DEBUGPOS   A newline delimited list of 1-indexed genomic
                        positions to output debug data when parsing the BAM
  --debughpos DEBUGHPOS
                        A comma delimited list of 1-indexed SNP positions to
                        output debug data when predicting haplotypes
  --dumpmatrix DUMPMATRIX
                        Location to dump the Hansel matrix to disk
  --dumpsnps DUMPSNPS   Location to dump the SNP positions to disk
  --pepper              enable a more permissive pileup by setting the pysam
                        pileup stepper to 'all', instead of 'samtools'. Note
                        that this will allow improper pairs.
  --version             show program's version number and exit
```

