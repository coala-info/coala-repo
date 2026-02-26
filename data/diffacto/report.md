# diffacto CWL Generation Report

## diffacto

### Tool Description
Diffacto: Differential analysis of (phospho)proteomics data

### Metadata
- **Docker Image**: quay.io/biocontainers/diffacto:1.0.7--pyh7cba7a3_0
- **Homepage**: https://github.com/statisticalbiotechnology/diffacto
- **Package**: https://anaconda.org/channels/bioconda/packages/diffacto/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/diffacto/overview
- **Total Downloads**: 3.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/statisticalbiotechnology/diffacto
- **Stars**: N/A
### Original Help Text
```text
usage: diffacto [-h] -i I [-db [DB]] [-samples [SAMPLES]] [-log2 LOG2]
                [-normalize {average,median,GMM,None}] [-farms_mu FARMS_MU]
                [-farms_alpha FARMS_ALPHA] [-reference REFERENCE]
                [-min_samples MIN_SAMPLES] [-use_unique USE_UNIQUE]
                [-impute_threshold IMPUTE_THRESHOLD]
                [-cutoff_weight CUTOFF_WEIGHT] [-fast FAST] [-out OUT]
                [-mc_out MC_OUT] [-loadings_out LOADINGS_OUT]

options:
  -h, --help            show this help message and exit
  -i I                  Peptides abundances in CSV format. The first row
                        should contain names for all samples. The first column
                        should contain unique peptide sequences. Missing
                        values should be empty instead of zeros. (default:
                        None)
  -db [DB]              Protein database in FASTA format. If None, the peptide
                        file must have protein ID(s) in the second column.
                        (default: None)
  -samples [SAMPLES]    File of the sample list. One run and its sample group
                        per line, separated by tab. If None, read from peptide
                        file headings, then each run will be summarized as a
                        group. (default: None)
  -log2 LOG2            Input abundances are in log scale (True) or linear
                        scale (False) (default: False)
  -normalize {average,median,GMM,None}
                        Method for sample-wise normalization. (default: None)
  -farms_mu FARMS_MU    Hyperparameter mu (default: 0.1)
  -farms_alpha FARMS_ALPHA
                        Hyperparameter weight of prior probability (default:
                        0.1)
  -reference REFERENCE  Names of reference sample groups (separated by
                        semicolon) (default: average)
  -min_samples MIN_SAMPLES
                        Minimum number of samples peptides needed to be
                        quantified in (default: 1)
  -use_unique USE_UNIQUE
                        Use unique peptides only (default: False)
  -impute_threshold IMPUTE_THRESHOLD
                        Minimum fraction of missing values in the group.
                        Impute missing values if missing fraction is larger
                        than the threshold. (default: 0.99)
  -cutoff_weight CUTOFF_WEIGHT
                        Peptides weighted lower than the cutoff will be
                        excluded (default: 0.5)
  -fast FAST            Allow early termination in EM calculation when noise
                        is sufficiently small. (default: False)
  -out OUT              Path to output file (writing in TSV format). (default:
                        <_io.TextIOWrapper name='<stdout>' mode='w'
                        encoding='utf-8'>)
  -mc_out MC_OUT        Path to MCFDR output (writing in TSV format).
                        (default: None)
  -loadings_out LOADINGS_OUT
                        File for peptide loadings (writing in TSV format).
                        (default: None)
```

