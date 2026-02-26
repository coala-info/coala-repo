# padloc CWL Generation Report

## padloc

### Tool Description
Locate antiviral defence systems in prokaryotic genomes

### Metadata
- **Docker Image**: quay.io/biocontainers/padloc:2.0.0--hdfd78af_0
- **Homepage**: https://github.com/padlocbio/padloc
- **Package**: https://anaconda.org/channels/bioconda/packages/padloc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/padloc/overview
- **Total Downloads**: 429
- **Last updated**: 2026-01-04
- **GitHub**: https://github.com/padlocbio/padloc
- **Stars**: N/A
### Original Help Text
```text
___       ___                           ___       ___   
       /  /\     /  /\     _____               /  /\     /  /\  
      /  /::\   /  /::\   /  /::\   ___  __   /  /::\   /  /:/_
     /  /:/:/  /  /:/::\ /  /:/\:\ /  /\/ /\ /  /:/\:\ /  /:/ /\
     \  \::/   \  \::/\/ \  \:\/:/ \  \:\/:/ \  \:\/:/ \  \:\/:/
      \  \:\    \  \:\    \  \::/   \  \::/   \  \::/   \  \::/  
       \__\/     \__\/     \__\/     \__\/     \__\/     \__\/          

PADLOC :: Locate antiviral defence systems in prokaryotic genomes

Usage:
  padloc [options] --faa <genome.faa> --gff <features.gff>
  padloc [options] --fna <genome.fna>

General:
  --help            Print this help message
  --version         Print version information
  --citation        Print citation information
  --check-deps      Check that dependencies are installed
  --debug           Run with debug messages
Database:
  --db-list         List all PADLOC-DB releases
  --db-install [n]  Install specific PADLOC-DB release [n]
  --db-update       Install latest PADLOC-DB release
  --db-version      Print database version information
Input:
  --faa [f]         Amino acid FASTA file (only valid with [--gff])
  --gff [f]         GFF file (only valid with [--faa])
  --fna [f]         Nucleic acid FASTA file
  --crispr [f]      CRISPRDetect output file containing array data
                    To pre-compute this file see instructions at:
                    'https://github.com/padlocbio/padloc/tree/master/etc'
  --ncrna [f]       Infernal output file containing ncRNA data
                    To pre-compute this file see instructions in:
                    'https://github.com/padlocbio/padloc/tree/master/etc'
Output:
  --outdir [d]      Output directory
Optional:
  --data [d]        Data directory (default '/usr/local/data')
  --cpu [n]         Use [n] CPUs (default '1')
  --fix-prodigal    Set this flag when providing an FAA and GFF file
                    generated with prodigal to force fixing of sequence IDs

Example input files can be found at:
/usr/local/test
```

