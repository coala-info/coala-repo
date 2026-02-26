# gdsctools CWL Generation Report

## gdsctools_gdsctools_anova

### Tool Description
Welcome to GDSCTools standalone

### Metadata
- **Docker Image**: quay.io/biocontainers/gdsctools:1.0.1--py_0
- **Homepage**: http://pypi.python.org/pypi/gdsctools
- **Package**: https://anaconda.org/channels/bioconda/packages/gdsctools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gdsctools/overview
- **Total Downloads**: 15.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Welcome to GDSCTools standalone
===============================================
None
['/usr/local/bin/gdsctools_anova', '--help']
['/usr/local/bin/gdsctools_anova', '--help']
usage: 

1. analyse all IC50s data contained in <filename> and open and HTML page
   in a browser. This can be very long (5 minutes to several hours) depending
   on the size of the files:

    gdsctools_anova --input-ic50 <filename>

2. on the same data as above, analyse only one association for a given
   drug <drug> and a given genomic features <feature>. The drug name should
   match one to be found in the header of <filename>. The feature name
   should match one of the header of the genomic feature file or if you use
   the default file, one of the feature in the default file (e.g., BRAF_mut)

   gdsctools_anova --input-ic50 <filename> --drug <drug> --feature <feature>

3. on the same data as above, analyse one drug across all features.

    gdsctools_anova --input-ic50 <filename> --drug <drug>

to obtain more help about the parameters, please type

    gdsctools_anova --help
    

General Description:

optional arguments:
  -h, --help            show this help message and exit

General:
  General options (compulsary or not)

  -I INPUT_IC50, --input-ic50 INPUT_IC50
                        A file in TSV format with IC50s. First column should
                        be the COSMIC identifiers Following columns contain
                        the IC50s for a set of drugs. The header must be
                        COSMIC_ID, Drug_1_IC50, Drug_2_IC50, ...
  -F INPUT_FEATURES, --input-features INPUT_FEATURES
                        A matrix of genomic features. One column with COSMIC
                        identifiers should match those from the IC50s matrix.
                        Then columns named TISSUE_FACTOR, MSI_FACTOR,
                        MEDIA_FACTOR should be provided. Finally, other
                        columns will be considered as genomic features (e.g.,
                        mutation)
  -D INPUT_DRUG_DECODE, --input-drug-decode INPUT_DRUG_DECODE
                        a decoder file
  --output-directory DIRECTORY
                        directory where to save images and HTML files.
  --verbose             verbose option.
  --do-not-open-report  By default, opens the index.html page. Set this option
                        if you do not want to open the html page
                        automatically.
  -d DRUG, --drug DRUG  The name of a valid drug identifier to be found in the
                        header of the IC50 matrix
  -f FEATURE, --feature FEATURE
                        The name of a valid feature to be found in the Genomic
                        Feature matrix
  --print-drug-names    Print the drug names
  --print-feature-names
                        Print the features names
  --print-tissue-names  Print the unique tissue names
  -t TISSUE, --tissue TISSUE
                        The name of a specific cancer type i.e., tissue to
                        restrict the analysis to.
  --FDR-threshold FDR_THRESHOLD
                        FDR (False discovery Rate) used in the multitesting
                        analysis to correct the pvalues
  --exclude-msi         Include msi factor in the analysis
  --save-settings SAVE_SETTINGS
                        Save settings into a json file
  --read-settings SETTINGS
                        Read settings from a json file. Type --save-settings
                        <filename.json> to create an example. Note that the
                        FDR-threshold and include_MSI_factor will be replaced
                        if --exclude-msi or fdr-threshold are used.
  --summary             Print summary about the data (e.g., tissue)
  --test                Use a small IC50 data set and run the one-drug-one-
                        feature analyse with a couple of unit tests.
  --no-html             If set, no images or HTML are created. For testing
                        only
  --version             print current version of this application

Author(s): Thomas Cokelaer (GDSCtools) and authors from the GDSCtools repository.

How to contribute ? : Visit https://github.com/CancerRxGene/gdsctools
Issues or bug report ? Please fill an issue on
http://github.com/CancerRxGene/gdsctools/issues
```

