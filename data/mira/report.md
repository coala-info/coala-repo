# mira CWL Generation Report

## mira

### Tool Description
A multi-pass sequencing data assembler or mapper for small genomes and
EST/RNASeq projects.

### Metadata
- **Docker Image**: quay.io/biocontainers/mira:5.0.0rc2--hb5a7bbe_0
- **Homepage**: https://github.com/DrMicrobit/mira
- **Package**: https://anaconda.org/channels/bioconda/packages/mira/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mira/overview
- **Total Downloads**: 29.6K
- **Last updated**: 2025-09-24
- **GitHub**: https://github.com/DrMicrobit/mira
- **Stars**: N/A
### Original Help Text
```text
Usage: mira [options] manifest_file [manifest_file ...]

A multi-pass sequencing data assembler or mapper for small genomes and
EST/RNASeq projects.

Recommended scope of usage:
  - de-novo assembly of haploid organisms, < ~40 megabases.
  - mapping / polishing genomes: < ~40 megabases.
  - EST/RNA assembly or maping: 40 to 60m reads.
  - Sanger and Illumina work well. Ion Torrent and 454 are ok.
  - Do not use with PacBio or Oxford Nanopore reads.

Options:
  -h / --help				Print short help and exit
  -c / --cwd=		directory	Change working directory
  -m / --mcheck				Only check the manifest file, then exit.
  -M / --mdcheck			Like -m, but also check existence of
					 data files.
  -r / --resume				Resume/restart an interrupted assembly
  -t / --threads=	integer		Force number of threads (overrides
					 equivalent -GE:not manifest entry)
  -v / --version			Print version and exit

Reporting bugs:
Please use the GitHub issue tracker at https://github.com/bachev/mira/issues
```


## Metadata
- **Skill**: generated
