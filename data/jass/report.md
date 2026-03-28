# jass CWL Generation Report

## jass_serve

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/jass:2.3--pyhca03a8a_0
- **Homepage**: http://statistical-genetics.pages.pasteur.fr/jass/
- **Package**: https://anaconda.org/channels/bioconda/packages/jass/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/jass/overview
- **Total Downloads**: 9.6K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
**     *******      *******   *******
        **    **     **    **        **
        **   **       **   **        **
        **   **       **    ******    ******
        **   ***********         **        **
 **     **   **       **         **        **
  *******    **       **   *******   *******


usage: jass serve [-h]
jass serve: error: argument -h/--help: ignored explicit argument 'elp'
```


## jass_list-phenotypes

### Tool Description
List available phenotypes

### Metadata
- **Docker Image**: quay.io/biocontainers/jass:2.3--pyhca03a8a_0
- **Homepage**: http://statistical-genetics.pages.pasteur.fr/jass/
- **Package**: https://anaconda.org/channels/bioconda/packages/jass/overview
- **Validation**: PASS

### Original Help Text
```text
**     *******      *******   *******
        **    **     **    **        **
        **   **       **   **        **
        **   **       **    ******    ******
        **   ***********         **        **
 **     **   **       **         **        **
  *******    **       **   *******   *******


usage: jass list-phenotypes [-h] [--init-table-path INIT_TABLE_PATH]
jass list-phenotypes: error: argument -h/--help: ignored explicit argument 'elp'
```


## jass_create-project-data

### Tool Description
Create project data for JASS

### Metadata
- **Docker Image**: quay.io/biocontainers/jass:2.3--pyhca03a8a_0
- **Homepage**: http://statistical-genetics.pages.pasteur.fr/jass/
- **Package**: https://anaconda.org/channels/bioconda/packages/jass/overview
- **Validation**: PASS

### Original Help Text
```text
usage: jass create-project-data [-h] [--init-table-path INIT_TABLE_PATH]
                                --phenotypes PHENOTYPES [PHENOTYPES ...]
                                --worktable-path WORKTABLE_PATH
                                [--remove-nans]
                                [--manhattan-plot-path MANHATTAN_PLOT_PATH]
                                [--quadrant-plot-path QUADRANT_PLOT_PATH]
                                [--zoom-plot-path ZOOM_PLOT_PATH]
                                [--qq-plot-path QQ_PLOT_PATH]
                                [--significance-treshold SIGNIFICANCE_TRESHOLD]
                                [--post-filtering POST_FILTERING]
                                [--custom-loadings CUSTOM_LOADINGS]
                                [--chunk-size CHUNK_SIZE]
                                [--csv-file-path CSV_FILE_PATH]
                                [--chromosome-number CHROMOSOME_NUMBER]
                                [--start-position START_POSITION]
                                [--end-position END_POSITION]
                                [--omnibus | --sumz | --fisher_test | --meta_analysis | --strategy STRATEGY]

options:
  -h, --help            show this help message and exit
  --init-table-path INIT_TABLE_PATH
                        path to the initial data file, default is the
                        configured path (JASS_DATA_DIR/initTable.hdf5)
  --phenotypes PHENOTYPES [PHENOTYPES ...]
                        list of selected phenotypes
  --worktable-path WORKTABLE_PATH
                        path to the worktable file to generate
  --remove-nans
  --manhattan-plot-path MANHATTAN_PLOT_PATH
                        path to the genome-wide manhattan plot to generate
  --quadrant-plot-path QUADRANT_PLOT_PATH
                        path to the quadrant plot to generate
  --zoom-plot-path ZOOM_PLOT_PATH
                        path to the local plot to generate
  --qq-plot-path QQ_PLOT_PATH
                        path to the quantile-quantile plot to generate
  --significance-treshold SIGNIFICANCE_TRESHOLD
                        The treshold at which a p-value is considered
                        significant
  --post-filtering POST_FILTERING
                        If a filtering to remove outlier will be applied (in
                        this case the result of SNPs considered aberant will
                        not appear in the worktable)
  --custom-loadings CUSTOM_LOADINGS
                        path toward a csv file containing custom loading for
                        sumZ tests
  --chunk-size CHUNK_SIZE
                        Number of region to load in memory at once
  --csv-file-path CSV_FILE_PATH
                        path to the results file in csv format
  --chromosome-number CHROMOSOME_NUMBER
                        option used only for local analysis: chromosome number
                        studied
  --start-position START_POSITION
                        option used only for local analysis: start position of
                        the region studied
  --end-position END_POSITION
                        option used only for local analysis: end position of
                        the region studied
  --omnibus
  --sumz
  --fisher_test
  --meta_analysis
  --strategy STRATEGY
```


## jass_clean-project-data

### Tool Description
Cleans project data by removing files that have not been accessed for a specified number of days.

### Metadata
- **Docker Image**: quay.io/biocontainers/jass:2.3--pyhca03a8a_0
- **Homepage**: http://statistical-genetics.pages.pasteur.fr/jass/
- **Package**: https://anaconda.org/channels/bioconda/packages/jass/overview
- **Validation**: PASS

### Original Help Text
```text
**     *******      *******   *******
        **    **     **    **        **
        **   **       **   **        **
        **   **       **    ******    ******
        **   ***********         **        **
 **     **   **       **         **        **
  *******    **       **   *******   *******


usage: jass clean-project-data [-h]
                               [--max-days-without-access MAX_DAYS_WITHOUT_ACCESS]
jass clean-project-data: error: argument -h/--help: ignored explicit argument 'elp'
```


## jass_create-inittable

### Tool Description
Creates an initial table for JASS based on input data and configuration.

### Metadata
- **Docker Image**: quay.io/biocontainers/jass:2.3--pyhca03a8a_0
- **Homepage**: http://statistical-genetics.pages.pasteur.fr/jass/
- **Package**: https://anaconda.org/channels/bioconda/packages/jass/overview
- **Validation**: PASS

### Original Help Text
```text
usage: jass create-inittable [-h] --input-data-path INPUT_DATA_PATH
                             [--init-covariance-path INIT_COVARIANCE_PATH]
                             --regions-map-path REGIONS_MAP_PATH
                             --description-file-path DESCRIPTION_FILE_PATH
                             [--init-table-path INIT_TABLE_PATH]
                             [--init-genetic-covariance-path INIT_GENETIC_COVARIANCE_PATH]

options:
  -h, --help            show this help message and exit
  --input-data-path INPUT_DATA_PATH
                        path to the GWAS data file (ImpG format) to import.
                        the path must be specify between quotes
  --init-covariance-path INIT_COVARIANCE_PATH
                        path to the covariance file to import
  --regions-map-path REGIONS_MAP_PATH
                        path to the genome regions map (BED format) to import
  --description-file-path DESCRIPTION_FILE_PATH
                        path to the GWAS studies metadata file
  --init-table-path INIT_TABLE_PATH
                        path to the initial data file to produce, default is
                        the configured path (JASS_DATA_DIR/initTable.hdf5)
  --init-genetic-covariance-path INIT_GENETIC_COVARIANCE_PATH
                        path to the genetic covariance file to import. Used
                        only for display on Jass web application
```


## jass_create-worktable

### Tool Description
Create a worktable for JASS analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/jass:2.3--pyhca03a8a_0
- **Homepage**: http://statistical-genetics.pages.pasteur.fr/jass/
- **Package**: https://anaconda.org/channels/bioconda/packages/jass/overview
- **Validation**: PASS

### Original Help Text
```text
usage: jass create-worktable [-h] [--init-table-path INIT_TABLE_PATH]
                             --phenotypes PHENOTYPES [PHENOTYPES ...]
                             --worktable-path WORKTABLE_PATH
                             [--significance-treshold SIGNIFICANCE_TRESHOLD]
                             [--post-filtering POST_FILTERING]
                             [--custom-loadings CUSTOM_LOADINGS]
                             [--csv-file-path CSV_FILE_PATH]
                             [--chunk-size CHUNK_SIZE] [--remove-nans]
                             [--chromosome-number CHROMOSOME_NUMBER]
                             [--start-position START_POSITION]
                             [--end-position END_POSITION]
                             [--omnibus | --sumz | --fisher_test | --meta_analysis | --strategy STRATEGY]

options:
  -h, --help            show this help message and exit
  --init-table-path INIT_TABLE_PATH
                        path to the initial data table, default is the
                        configured path (JASS_DATA_DIR/initTable.hdf5)
  --phenotypes PHENOTYPES [PHENOTYPES ...]
                        list of selected phenotypes
  --worktable-path WORKTABLE_PATH
                        path to the worktable file to generate
  --significance-treshold SIGNIFICANCE_TRESHOLD
                        threshold at which a p-value is considered significant
  --post-filtering POST_FILTERING
                        If a filtering to remove outlier will be applied (in
                        this case the result of SNPs considered aberant will
                        not appear in the worktable)
  --custom-loadings CUSTOM_LOADINGS
                        path toward a csv file containing custom loading for
                        sumZ tests
  --csv-file-path CSV_FILE_PATH
                        path to the results file in csv format
  --chunk-size CHUNK_SIZE
                        Number of region to load in memory at once
  --remove-nans
  --chromosome-number CHROMOSOME_NUMBER
                        option used only for local analysis: chromosome number
                        studied
  --start-position START_POSITION
                        option used only for local analysis: start position of
                        the region studied
  --end-position END_POSITION
                        option used only for local analysis: end position of
                        the region studied
  --omnibus
  --sumz
  --fisher_test
  --meta_analysis
  --strategy STRATEGY
```


## jass_plot-manhattan

### Tool Description
Generates a Manhattan plot from a JASS worktable.

### Metadata
- **Docker Image**: quay.io/biocontainers/jass:2.3--pyhca03a8a_0
- **Homepage**: http://statistical-genetics.pages.pasteur.fr/jass/
- **Package**: https://anaconda.org/channels/bioconda/packages/jass/overview
- **Validation**: PASS

### Original Help Text
```text
**     *******      *******   *******
        **    **     **    **        **
        **   **       **   **        **
        **   **       **    ******    ******
        **   ***********         **        **
 **     **   **       **         **        **
  *******    **       **   *******   *******


usage: jass plot-manhattan [-h] --worktable-path WORKTABLE_PATH --plot-path
                           PLOT_PATH
jass plot-manhattan: error: the following arguments are required: --worktable-path, --plot-path
```


## jass_qq-plot

### Tool Description
Generates a QQ plot from a worktable.

### Metadata
- **Docker Image**: quay.io/biocontainers/jass:2.3--pyhca03a8a_0
- **Homepage**: http://statistical-genetics.pages.pasteur.fr/jass/
- **Package**: https://anaconda.org/channels/bioconda/packages/jass/overview
- **Validation**: PASS

### Original Help Text
```text
**     *******      *******   *******
        **    **     **    **        **
        **   **       **   **        **
        **   **       **    ******    ******
        **   ***********         **        **
 **     **   **       **         **        **
  *******    **       **   *******   *******


usage: jass qq-plot [-h] --worktable-path WORKTABLE_PATH --plot-path PLOT_PATH
jass qq-plot: error: argument -h/--help: ignored explicit argument 'elp'
```


## jass_plot-quadrant

### Tool Description
Generates a quadrant plot from a worktable.

### Metadata
- **Docker Image**: quay.io/biocontainers/jass:2.3--pyhca03a8a_0
- **Homepage**: http://statistical-genetics.pages.pasteur.fr/jass/
- **Package**: https://anaconda.org/channels/bioconda/packages/jass/overview
- **Validation**: PASS

### Original Help Text
```text
usage: jass plot-quadrant [-h] --worktable-path WORKTABLE_PATH --plot-path
                          PLOT_PATH
                          [--significance-treshold SIGNIFICANCE_TRESHOLD]

options:
  -h, --help            show this help message and exit
  --worktable-path WORKTABLE_PATH
                        path to the worktable file containing the data
  --plot-path PLOT_PATH
                        path to the quadrant plot file to generate
  --significance-treshold SIGNIFICANCE_TRESHOLD
                        threshold at which a p-value is considered significant
```


## jass_add-gene-annotation

### Tool Description
Add gene annotation to an initial table.

### Metadata
- **Docker Image**: quay.io/biocontainers/jass:2.3--pyhca03a8a_0
- **Homepage**: http://statistical-genetics.pages.pasteur.fr/jass/
- **Package**: https://anaconda.org/channels/bioconda/packages/jass/overview
- **Validation**: PASS

### Original Help Text
```text
usage: jass add-gene-annotation [-h] --gene-data-path GENE_DATA_PATH
                                --init-table-path INIT_TABLE_PATH
                                [--gene-csv-path GENE_CSV_PATH]
                                [--exon-csv-path EXON_CSV_PATH]

options:
  -h, --help            show this help message and exit
  --gene-data-path GENE_DATA_PATH
                        path to the GFF file containing gene and exon data
  --init-table-path INIT_TABLE_PATH
                        path to the initial table file to update
  --gene-csv-path GENE_CSV_PATH
                        path to the file df_gene.csv
  --exon-csv-path EXON_CSV_PATH
                        path to the file df_exon.csv
```


## jass_extract-tsv

### Tool Description
Extracts data from an HDF5 table to a TSV file.

### Metadata
- **Docker Image**: quay.io/biocontainers/jass:2.3--pyhca03a8a_0
- **Homepage**: http://statistical-genetics.pages.pasteur.fr/jass/
- **Package**: https://anaconda.org/channels/bioconda/packages/jass/overview
- **Validation**: PASS

### Original Help Text
```text
usage: jass extract-tsv [-h] --hdf5-table-path HDF5_TABLE_PATH --tsv-path
                        TSV_PATH [--table-key TABLE_KEY]

options:
  -h, --help            show this help message and exit
  --hdf5-table-path HDF5_TABLE_PATH
                        path to the worktable file containing the data
  --tsv-path TSV_PATH   path to the tsv table
  --table-key TABLE_KEY
                        Existing key are 'SumStatTab' : The results of the
                        joint analysis by SNPs - 'PhenoList' : the meta data
                        of analysed GWAS - 'COV' : The H0 covariance used to
                        perform joint analysis - 'GENCOV' (If present in the
                        initTable): The genetic covariance as computed by the
                        LDscore. Uniquely for the worktable: 'Regions' :
                        Results of the joint analysis summarised by LD regions
                        (Notably Lead SNPs by regions) - 'summaryTable': a
                        double entry table summarizing the number of
                        significant regions by test (univariate vs joint test)
```


## Metadata
- **Skill**: generated
