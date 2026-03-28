# raiss CWL Generation Report

## raiss_sanity-check

### Tool Description
Sanity check for RAISS imputation.

### Metadata
- **Docker Image**: quay.io/biocontainers/raiss:4.0.1--pyhdfd78af_0
- **Homepage**: http://statistical-genetics.pages.pasteur.fr/raiss/
- **Package**: https://anaconda.org/channels/bioconda/packages/raiss/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/raiss/overview
- **Total Downloads**: 11.7K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
/usr/local/lib/python3.12/site-packages/raiss/ld_matrix.py:75: SyntaxWarning: invalid escape sequence '\s'
  plink_ld = pd.read_csv(plink_ld, sep = "\s+")
/usr/local/lib/python3.12/site-packages/raiss/windows.py:126: SyntaxWarning: invalid escape sequence '\%'
  print("{0}\%".format(np.round(i/Nwindows,3)))
/usr/local/lib/python3.12/site-packages/raiss/__main__.py:92: SyntaxWarning: invalid escape sequence '\d'
  parser.add_argument('--chrom', help= "chromosome to impute to the chr\d+ format")

  *******       *******    *******   *******   *******
  **     **    **     **     ***    **        **
  **     **   **       **    ***    **        **
  ** *****    **       **    ***      ******    ******
  **     **   ***********    ***           **        **
  **     **   **       **    ***           **        **
  **     **   **       **  *******   *******   *******


usage: raiss sanity-check [-h] --trait TRAIT --harmonized-folder
                          HARMONIZED_FOLDER --imputed-folder IMPUTED_FOLDER
                          [--output-path OUTPUT_PATH] [--chr-list CHR_LIST]
raiss sanity-check: error: the following arguments are required: --trait, --harmonized-folder, --imputed-folder
```


## raiss_performance-grid-search

### Tool Description
Performs a grid search for RAISS performance tuning.

### Metadata
- **Docker Image**: quay.io/biocontainers/raiss:4.0.1--pyhdfd78af_0
- **Homepage**: http://statistical-genetics.pages.pasteur.fr/raiss/
- **Package**: https://anaconda.org/channels/bioconda/packages/raiss/overview
- **Validation**: PASS

### Original Help Text
```text
usage: raiss performance-grid-search [-h] --harmonized-folder
                                     HARMONIZED_FOLDER --masked-folder
                                     MASKED_FOLDER --imputed-folder
                                     IMPUTED_FOLDER --output-path OUTPUT_PATH
                                     --eigen-ratio-grid EIGEN_RATIO_GRID
                                     [--ld-threshold-grid LD_THRESHOLD_GRID]
                                     [--N-to-mask N_TO_MASK] [--n-cpu N_CPU]

options:
  -h, --help            show this help message and exit
  --harmonized-folder HARMONIZED_FOLDER
                        folder containing data before imputation
  --masked-folder MASKED_FOLDER
                        folder to store zscore with masked SNPs (raiss
                        performance-grid-search will generate them)
  --imputed-folder IMPUTED_FOLDER
                        folder to store imputed files
  --output-path OUTPUT_PATH
                        path+prefix of the report file, the file will be
                        suffixed by the trait name and .txt
  --eigen-ratio-grid EIGEN_RATIO_GRID
                        main parameter to tune. Adjust the regularization when
                        computing the pseudo inverse of LD matrices
  --ld-threshold-grid LD_THRESHOLD_GRID
                        optional parameter to tune. raising the threshold will
                        augment the number neighboring of SNPs required for
                        the imputation to be consider valid (i.e. missing SNPs
                        with only few neighbor won't be imputed). Empirically
                        this parameter seems to impact more the maximum error
                        than the mean/median error
  --N-to-mask N_TO_MASK
                        Number of SNPs to mask. Should only be a relatively
                        small fraction (e.g. ~1/10)of the number of your
                        initial data
  --n-cpu N_CPU         Number of cpu to use to run imputation in Parallel for
                        each parameter value
```


## Metadata
- **Skill**: generated
