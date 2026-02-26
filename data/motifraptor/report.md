# motifraptor CWL Generation Report

## motifraptor_MotifRaptor

### Tool Description
Analyze motifs and SNPs in the dataset.

### Metadata
- **Docker Image**: quay.io/biocontainers/motifraptor:0.3.0--py36h40b2fa4_5
- **Homepage**: https://github.com/pinellolab/MotifRaptor
- **Package**: https://anaconda.org/channels/bioconda/packages/motifraptor/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/motifraptor/overview
- **Total Downloads**: 15.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/pinellolab/MotifRaptor
- **Stars**: N/A
### Original Help Text
```text
usage: MotifRaptor [-h] [--version]
                   {preprocess,preprocess_ukbb_v3,celltype,snpmotif,snpfeature,motiffilter,motifspecific,snpspecific,snpmotifradar,snpindex,snpscan,set,info}
                   ...

Analyze motifs and SNPs in the dataset.

positional arguments:
  {preprocess,preprocess_ukbb_v3,celltype,snpmotif,snpfeature,motiffilter,motifspecific,snpspecific,snpmotifradar,snpindex,snpscan,set,info}
                        help for subcommand: celltype, snpmotif, snpfeature,
                        motiffilter, motifspecific, snpspecific
    preprocess          Pre-process the summary statistics
    preprocess_ukbb_v3  Pre-process the summary statistics from UKBB version 3
                        TSV files
    celltype            cell type or tissue type analysis help
    snpmotif            snp motif test help
    snpfeature          snp feature help
    motiffilter         motifs filtering help
    motifspecific       motifs specific analysis help
    snpspecific         SNP specific analysis help
    snpmotifradar       SNP motif radar plot help
    snpindex            index the SNPs (with flanking sequences) help
    snpscan             scan SNP database (already indexed) help
    set                 Set Path and Global Values
    info                Get Informationa and Print Global Values

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
```

