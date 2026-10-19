# raiss CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| raiss | Not completed | needs harmonized GWAS z-scores, LD matrices and a reference panel for a chromosome; no small real data set found |
| raiss_performance-grid-search | Not completed | needs harmonized GWAS z-scores, LD matrices and a reference panel for a chromosome; no small real data set found |
| raiss_sanity-check | Not completed | needs harmonized GWAS z-scores, LD matrices and a reference panel for a chromosome; no small real data set found |

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


## raiss

### Tool Description
options:

### Metadata
- **Docker Image**: quay.io/biocontainers/raiss:4.0.1--pyhdfd78af_0
- **Homepage**: http://statistical-genetics.pages.pasteur.fr/raiss/
- **Package**: https://anaconda.org/channels/bioconda/packages/raiss/overview
- **Validation**: PASS

### Original Help Text
```text
options:
  -h, --help            show this help message and exit
  --chrom CHROM         chromosome to impute to the chr\d+ format
  --gwas GWAS           GWAS to impute to the consortia_trait format
  --ref-folder REF_FOLDER
                        reference panel location (used to determine which snp
                        to impute)
  --ld-folder LD_FOLDER
                        Location LD correlation matrices
  --zscore-folder ZSCORE_FOLDER
                        Location of the zscore files of the gwases to impute
  --output-folder OUTPUT_FOLDER
                        Location of the impute zscore files
  --window-size WINDOW_SIZE
                        Size of the non overlapping window
  --buffer-size BUFFER_SIZE
                        Size of the buffer around the imputation window
  --l2-regularization L2_REGULARIZATION
                        Size of the small value added to the diagonal of the
                        covariance matrix before inversion
  --eigen-threshold EIGEN_THRESHOLD
                        threshold under which eigen vectors are removed for
                        the computation of the pseudo inverse
  --R2-threshold R2_THRESHOLD
                        R square (imputation quality) threshold bellow which
                        SNPs are filtered from the output
  --ld-type LD_TYPE     'Two options are available : 'plink' or 'scipy'. Ld
                        can be supplied as plink command --ld-snp-list output
                        files (see raiss.ld_matrix.launch_plink_ld to compute
                        these data using plink) or as a couple of a scipy
                        sparse matrix (.npz )and an .csv containing SNPs index
  --ref-panel-prefix REF_PANEL_PREFIX
                        prefix for the reference panel files
  --ref-panel-suffix REF_PANEL_SUFFIX
                        suffix for the reference panel files
  --minimum-ld MINIMUM_LD
                        this parameter ensure that their is enough typed SNPs
                        around the imputed loci to perform a high accuracy
                        imputation
usage: raiss [-h] [--chrom CHROM] [--gwas GWAS] [--ref-folder REF_FOLDER]
             [--ld-folder LD_FOLDER] [--zscore-folder ZSCORE_FOLDER]
             [--output-folder OUTPUT_FOLDER] [--window-size WINDOW_SIZE]
             [--buffer-size BUFFER_SIZE]
             [--l2-regularization L2_REGULARIZATION]
             [--eigen-threshold EIGEN_THRESHOLD] [--R2-threshold R2_THRESHOLD]
             [--ld-type LD_TYPE] [--ref-panel-prefix REF_PANEL_PREFIX]
             [--ref-panel-suffix REF_PANEL_SUFFIX] [--minimum-ld MINIMUM_LD]
             {sanity-check,performance-grid-search} ...
```

## Metadata
- **Skill**: generated
