# triqler CWL Generation Report

## triqler

### Tool Description
Triqler version 0.9.1

### Metadata
- **Docker Image**: quay.io/biocontainers/triqler:0.9.1--pyhdfd78af_0
- **Homepage**: https://github.com/statisticalbiotechnology/triqler
- **Package**: https://anaconda.org/channels/bioconda/packages/triqler/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/triqler/overview
- **Total Downloads**: 24.3K
- **Last updated**: 2025-10-05
- **GitHub**: https://github.com/statisticalbiotechnology/triqler
- **Stars**: N/A
### Original Help Text
```text
Triqler version 0.9.1
Copyright (c) 2018-2024 Matthew The, Patrick Truong. All rights reserved.
Written by:
- Matthew The (matthew.the@scilifelab.se)
- Patrick Truong (patrick.truong@scilifelab.se)
in the School of Engineering Sciences in Chemistry, Biotechnology and Health
at the Royal Institute of Technology in Stockholm.
Issued command: triqler.py --help
usage: triqler [-h] [--out_file OUT] [--fold_change_eval F]
               [--decoy_pattern P] [--protein_name_separator P]
               [--missing_value_prior D] [--min_samples N] [--num_threads N]
               [--ttest] [--write_spectrum_quants]
               [--write_protein_posteriors P_OUT]
               [--write_group_posteriors G_OUT]
               [--write_fold_change_posteriors F_OUT]
               [--csv-field-size-limit CSV_FIELD_SIZE_LIMIT]
               IN_FILE

positional arguments:
  IN_FILE               List of PSMs with abundances (not log transformed!)
                        and search engine score. See README for a detailed
                        description of the columns.

options:
  -h, --help            show this help message and exit
  --out_file OUT        Path to output file (writing in TSV format). N.B. if
                        more than 2 treatment groups are present, suffixes
                        will be added before the file extension. (default:
                        proteins.tsv)
  --fold_change_eval F  log2 fold change evaluation threshold. (default: 1.0)
  --decoy_pattern P     Prefix for decoy proteins. (default: decoy_)
  --protein_name_separator P
                        Separator used in tab delimited input and output for
                        separating protein names. (default: )
  --missing_value_prior D
                        Distribution to fit for missing value prior. Use "DIA"
                        for using means of NaNs to fit the censored normal
                        distribution. The "default" option fits the censored
                        normal distribution with all observed XIC values.
                        (default: default)
  --min_samples N       Minimum number of samples a peptide needed to be
                        quantified in. (default: 2)
  --num_threads N       Number of threads, by default this is equal to the
                        number of CPU cores available on the device. (default:
                        20)
  --ttest               Use t-test for evaluating differential expression
                        instead of posterior probabilities. (default: False)
  --write_spectrum_quants
                        Write quantifications for consensus spectra. Only
                        works if consensus spectrum index are given in input.
                        (default: False)
  --write_protein_posteriors P_OUT
                        Write raw data of protein posteriors to the specified
                        file in TSV format. (default: )
  --write_group_posteriors G_OUT
                        Write raw data of treatment group posteriors to the
                        specified file in TSV format. (default: )
  --write_fold_change_posteriors F_OUT
                        Write raw data of fold change posteriors to the
                        specified file in TSV format. (default: )
  --csv-field-size-limit CSV_FIELD_SIZE_LIMIT
                        Set a new maximum CSV field size (default: None)
```

