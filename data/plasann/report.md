# plasann CWL Generation Report

## plasann_PlasAnn

### Tool Description
PlasAnn v1.1.6 - Comprehensive Plasmid Annotation Pipeline

### Metadata
- **Docker Image**: quay.io/biocontainers/plasann:1.1.6--pyhdfd78af_0
- **Homepage**: https://github.com/ajlopatkin/PlasAnn
- **Package**: https://anaconda.org/channels/bioconda/packages/plasann/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/plasann/overview
- **Total Downloads**: 1.2K
- **Last updated**: 2025-10-01
- **GitHub**: https://github.com/ajlopatkin/PlasAnn
- **Stars**: N/A
### Original Help Text
```text
usage: PlasAnn [-h] [--version] [--check-deps] [-i INPUT] [-o OUTPUT]
               [-t {fasta,genbank,auto}] [-n NAME] [--overwrite] [--retain]
               [--uniprot-blast] [--uniprot-tsv UNIPROT_TSV]
               [--min-identity MIN_IDENTITY]

PlasAnn v1.1.6 - Comprehensive Plasmid Annotation Pipeline

🧬 Features:
  • Gene prediction (Prodigal) and functional annotation (BLAST)
  • Mobile element detection (oriC, oriT, transposons, replicons)
  • ncRNA detection (Infernal/Rfam) and intergenic gene discovery
  • Optional UniProt BLAST enhancement for comprehensive annotation
  • Beautiful circular plasmid visualizations
  • Batch processing with auto-detection of mixed file types

📖 For detailed documentation, visit: https://github.com/ajlopakin/PlasAnn
        

options:
  -h, --help            show this help message and exit
  --version             Show PlasAnn version and exit
  --check-deps          Check external dependency status and exit
  -i, --input INPUT     Input FASTA or GenBank file/folder
  -o, --output OUTPUT   Output directory
  -t, --type {fasta,genbank,auto}
                        Input type: fasta, genbank, or auto (auto-detect from
                        folder)
  -n, --name NAME       Custom name for output subfolder (single files only -
                        ignored for folders)
  --overwrite           Use Prodigal on GenBank sequence (ignore existing
                        annotations)
  --retain              Use GenBank annotations with fallback to translation
                        (default)
  --uniprot-blast       Run optional UniProt BLAST annotation (slow but
                        comprehensive)
  --uniprot-tsv UNIPROT_TSV
                        Path to UniProt TSV file (default:
                        Database/uniprot_plasmids.tsv)
  --min-identity MIN_IDENTITY
                        Minimum identity percentage for UniProt BLAST hits
                        (default: 50%)

📚 Examples:

  Basic Usage:
    PlasAnn -i plasmid.fasta -o results -t fasta
    PlasAnn -i plasmid.gb -o results -t genbank
    PlasAnn -i mixed_folder/ -o results -t auto
  
  Enhanced Annotation:
    PlasAnn -i plasmid.fasta -o results -t fasta --uniprot-blast
  
  GenBank Processing Modes:
    PlasAnn -i plasmid.gb -o results -t genbank --retain   # Use original annotations
    PlasAnn -i plasmid.gb -o results -t genbank --overwrite # Re-annotate with Prodigal
  
  Batch Processing:
    PlasAnn -i fasta_folder/ -o results -t fasta
    PlasAnn -i mixed_folder/ -o results -t auto --uniprot-blast
  
  System Check:
    PlasAnn --check-deps
    PlasAnn --version

🔧 Dependencies: BLAST+, Prodigal, Infernal
   Install with: conda install -c bioconda blast prodigal infernal

💡 Tip: Use --uniprot-blast for comprehensive protein annotation (slower but thorough)
```

