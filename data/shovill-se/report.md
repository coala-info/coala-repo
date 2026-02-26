# shovill-se CWL Generation Report

## shovill-se

### Tool Description
De novo assembly pipeline for Illumina single-end reads

### Metadata
- **Docker Image**: quay.io/biocontainers/shovill-se:1.1.0se--hdfd78af_2
- **Homepage**: https://github.com/rpetit3/shovill
- **Package**: https://anaconda.org/channels/bioconda/packages/shovill-se/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/shovill-se/overview
- **Total Downloads**: 7.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/rpetit3/shovill
- **Stars**: N/A
### Original Help Text
```text
SYNOPSIS
  De novo assembly pipeline for Illumina single-end reads
USAGE
  shovill-se [options] --outdir DIR --se SE.fq.gz
GENERAL
  --help          This help
  --version       Print version and exit
  --check         Check dependencies are installed
INPUT
  --se|single XXX Single-end reads (default: '')
  --depth N       Sub-sample --R1/--R2 to this depth. Disable with --depth 0 (default: 150)
  --gsize XXX     Estimated genome size eg. 3.2M <blank=AUTODETECT> (default: '')
OUTPUT
  --outdir XXX    Output folder (default: '')
  --force         Force overwite of existing output folder (default: OFF)
  --minlen N      Minimum contig length <0=AUTO> (default: 0)
  --mincov n.nn   Minimum contig coverage <0=AUTO> (default: 2)
  --namefmt XXX   Format of contig FASTA IDs in 'printf' style (default: 'contig%05d')
  --keepfiles     Keep intermediate files (default: OFF)
RESOURCES
  --tmpdir XXX    Fast temporary directory (default: '')
  --cpus N        Number of CPUs to use (0=ALL) (default: 8)
  --ram n.nn      Try to keep RAM usage below this many GB (default: 16)
ASSEMBLER
  --assembler XXX Assembler: spades skesa megahit velvet (default: 'spades')
  --opts XXX      Extra assembler options in quotes eg. spades: '--sc' ... (default: '')
  --kmers XXX     K-mers to use <blank=AUTO> (default: '')
MODULES
  --trim          Enable adaptor trimming (default: OFF)
  --noreadcorr    Disable read error correction (default: OFF)
  --nocorr        Disable post-assembly correction (default: OFF)
HOMEPAGE
  https://github.com/tseemann/shovill - Torsten Seemann
```

