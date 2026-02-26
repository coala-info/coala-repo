# ddprimer CWL Generation Report

## ddprimer

### Tool Description
A pipeline for primer design and filtering

### Metadata
- **Docker Image**: quay.io/biocontainers/ddprimer:0.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/globuzzz2000/ddPrimer
- **Package**: https://anaconda.org/channels/bioconda/packages/ddprimer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ddprimer/overview
- **Total Downloads**: 79
- **Last updated**: 2025-08-12
- **GitHub**: https://github.com/globuzzz2000/ddPrimer
- **Stars**: N/A
### Original Help Text
```text
usage: ddprimer [-h] [--debug [MODULE...]] [--config [.json]] [--db [.fasta, .fna, .fa] [DB_NAME]]
                [--cli]  [--nooligo] [--noannotation]
                [--direct [.csv, .xlsx]] [--snp]
                [--remap [.csv, .xlsx]]
                [--fasta [.fasta, .fna, .fa]] [--gff [.gff, .gff3]] [--vcf [.vcf, .vcf.gz]]\n                [--output <output_dir>]

ddPrimer: A pipeline for primer design and filtering

options:
  -h, --help            show this help message and exit

options:
  --debug [MODULE ...]  Enable debug mode. Use without arguments for universal
                        debug,or specify module names (e.g. "--debug
                        blast_processor").
  --config [[.json]]    Configuration file path. With no arguments, shows
                        config help mode.
  --db [[.fasta, .fna, .fa] [[DB_NAME] ...]]
                        Create or select a BLAST database. With no arguments,
                        shows database selection menu.Optionally use FASTA
                        file path argument to create database,optional second
                        argument to determine database name.
  --cli                 Force CLI mode.
  --nooligo             Disable internal oligo (probe) design.
  --noannotation        Disable gene annotation filtering.
  --direct [[.csv, .xlsx]]
                        Enable target-sequence based primer design workflow
                        using CSV/Excel input.
  --snp                 Enable SNP masking in direct mode. Requires VCF and
                        FASTA files.
  --remap [[.csv, .xlsx]]
                        Enable primer remapping and re-evaluation workflow
                        using CSV/Excel input.

inputs (optional):
  --fasta [.fasta, .fna, .fa]
                        Reference genome FASTA file
  --vcf [.vcf, .vcf.gz]
                        Variant Call Format (VCF) file with variants
  --gff [.gff, .gff3]   GFF annotation file
  --output <output_dir>
                        Output directory
```

