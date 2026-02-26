# gfflu CWL Generation Report

## gfflu

### Tool Description
Annotate Influenza A virus sequences using Miniprot and BLASTX The Miniprot GFF for a particular reference sequence gene segment will have multiple annotations for the same gene. This script will select the top scoring annotation for each gene and write out a new GFF file that can be used with SnpEff.

### Metadata
- **Docker Image**: quay.io/biocontainers/gfflu:0.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/CFIA-NCFAD/gfflu
- **Package**: https://anaconda.org/channels/bioconda/packages/gfflu/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gfflu/overview
- **Total Downloads**: 3.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/CFIA-NCFAD/gfflu
- **Stars**: N/A
### Original Help Text
```text
Usage: gfflu [OPTIONS] FASTA                                                   
                                                                                
 Annotate Influenza A virus sequences using Miniprot and BLASTX                 
 The Miniprot GFF for a particular reference sequence gene segment will have    
 multiple annotations for the same gene. This script will select the top        
 scoring annotation for each gene and write out a new GFF file that can be used 
 with SnpEff.                                                                   
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    fasta      FILE  Influenza virus nucleotide sequence FASTA file         │
│                       [default: None]                                        │
│                       [required]                                             │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --outdir              -o      PATH  Output directory [default: gfflu-outdir] │
│ --force               -f            Overwrite existing files                 │
│ --prefix              -p      TEXT  Output file prefix [default: None]       │
│ --verbose             -v                                                     │
│ --version             -V            Print 'gfflu version 0.0.2' and exit     │
│ --install-completion                Install completion for the current       │
│                                     shell.                                   │
│ --show-completion                   Show completion for the current shell,   │
│                                     to copy it or customize the              │
│                                     installation.                            │
│ --help                              Show this message and exit.              │
╰──────────────────────────────────────────────────────────────────────────────╯
                                                                                
 gfflu version 0.0.2; Python 3.10.12
```

