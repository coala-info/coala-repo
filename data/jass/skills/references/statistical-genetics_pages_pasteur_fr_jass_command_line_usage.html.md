[JASS](index.html)

Contents:

* [What is JASS: A python package to perform Multi-trait GWAS](about.html)
* [Installation](install.html)
* [Data preparation](data_import.html)
* [Compute Multi-trait GWAS with JASS](generating_joint_analysis.html)
* [References](bibliography.html)
* Command line reference
  + [Positional Arguments](#positional-arguments)
  + [Sub-commands](#Sub-commands)
    - [list-phenotypes](#list-phenotypes)
      * [Named Arguments](#named-arguments)
    - [create-project-data](#create-project-data)
      * [Named Arguments](#named-arguments_repeat1)
    - [clean-project-data](#clean-project-data)
      * [Named Arguments](#named-arguments_repeat2)
    - [create-inittable](#create-inittable)
      * [Named Arguments](#named-arguments_repeat3)
    - [create-worktable](#create-worktable)
      * [Named Arguments](#named-arguments_repeat4)
    - [plot-manhattan](#plot-manhattan)
      * [Named Arguments](#named-arguments_repeat5)
    - [qq-plot](#qq-plot)
      * [Named Arguments](#named-arguments_repeat6)
    - [plot-quadrant](#plot-quadrant)
      * [Named Arguments](#named-arguments_repeat7)
    - [add-gene-annotation](#add-gene-annotation)
      * [Named Arguments](#named-arguments_repeat8)
    - [extract-tsv](#extract-tsv)
      * [Named Arguments](#named-arguments_repeat9)
    - [predict-gain](#predict-gain)
      * [Named Arguments](#named-arguments_repeat10)
* [Developer documentation](develop.html)

[JASS](index.html)

* Command line reference
* [Edit on GitLab](https://gitlab.pasteur.fr/statistical-genetics/jass/blob/master/doc/source/command_line_usage.rst)

---

# Command line reference[](#command-line-reference "Permalink to this heading")

This section contains the exhaustive list of the sub-commands and options available for JASS on the command line.

```
usage: jass [-h]
            {list-phenotypes,create-project-data,clean-project-data,create-inittable,create-worktable,plot-manhattan,qq-plot,plot-quadrant,add-gene-annotation,extract-tsv,predict-gain}
            ...
```

## Positional Arguments[](#positional-arguments "Permalink to this heading")

`action`
:   Possible choices: list-phenotypes, create-project-data, clean-project-data, create-inittable, create-worktable, plot-manhattan, qq-plot, plot-quadrant, add-gene-annotation, extract-tsv, predict-gain

## Sub-commands[](#Sub-commands "Permalink to this heading")

### list-phenotypes[](#list-phenotypes "Permalink to this heading")

list phenotypes available in a data file

```
jass list-phenotypes [-h] [--init-table-path INIT_TABLE_PATH]
```

#### Named Arguments[](#named-arguments "Permalink to this heading")

`--init-table-path`
:   path to the initial data file, default is the configured path (JASS\_DATA\_DIR/initTable.hdf5)

    Default: "/builds/statistical-genetics/jass/data/initTable.hdf5"

### create-project-data[](#create-project-data "Permalink to this heading")

compute joint statistics and generate plots for a given set of phenotypes

```
jass create-project-data [-h] [--init-table-path INIT_TABLE_PATH] --phenotypes
                         PHENOTYPES [PHENOTYPES ...] --worktable-path
                         WORKTABLE_PATH [--remove-nans]
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
                         [--end-position END_POSITION] [--omnibus | --sumz]
```

#### Named Arguments[](#named-arguments_repeat1 "Permalink to this heading")

`--init-table-path`
:   path to the initial data file, default is the configured path (JASS\_DATA\_DIR/initTable.hdf5)

    Default: "/builds/statistical-genetics/jass/data/initTable.hdf5"

`--phenotypes`
:   list of selected phenotypes

`--worktable-path`
:   path to the worktable file to generate

`--remove-nans`
:   Default: False

`--manhattan-plot-path`
:   path to the genome-wide manhattan plot to generate

`--quadrant-plot-path`
:   path to the quadrant plot to generate

`--zoom-plot-path`
:   path to the local plot to generate

`--qq-plot-path`
:   path to the quantile-quantile plot to generate

`--significance-treshold`
:   The treshold at which a p-value is considered significant

    Default: 5e-08

`--post-filtering`
:   If a filtering to remove outlier will be applied (in this case the result of SNPs considered aberant will not appear in the worktable)

    Default: True

`--custom-loadings`
:   path toward a csv file containing custom loading for sumZ tests

`--chunk-size`
:   Number of region to load in memory at once

    Default: 50

`--csv-file-path`
:   path to the results file in csv format

`--chromosome-number`
:   option used only for local analysis: chromosome number studied

`--start-position`
:   option used only for local analysis: start position of the region studied

`--end-position`
:   option used only for local analysis: end position of the region studied

`--omnibus`
:   Default: True

`--sumz`
:   Default: False

### clean-project-data[](#clean-project-data "Permalink to this heading")

Remove old projects data that haven't been accessed recently

```
jass clean-project-data [-h]
                        [--max-days-without-access MAX_DAYS_WITHOUT_ACCESS]
```

#### Named Arguments[](#named-arguments_repeat2 "Permalink to this heading")

`--max-days-without-access`
:   A project is marked for large file deletion if the number of days elapsed since the last access is greater than the amount provided.

    Default: 30

### create-inittable[](#create-inittable "Permalink to this heading")

import data into an initial data file

```
jass create-inittable [-h] --input-data-path INPUT_DATA_PATH
                      [--init-covariance-path INIT_COVARIANCE_PATH]
                      --regions-map-path REGIONS_MAP_PATH
                      --description-file-path DESCRIPTION_FILE_PATH
                      [--init-table-path INIT_TABLE_PATH]
                      [--init-genetic-covariance-path INIT_GENETIC_COVARIANCE_PATH]
                      [--init-table-metadata-path INIT_TABLE_METADATA_PATH]
```

#### Named Arguments[](#named-arguments_repeat3 "Permalink to this heading")

`--input-data-path`
:   path to the GWAS data file (ImpG format) to import. the path must be specify between quotes

`--init-covariance-path`
:   path to the covariance file to import

`--regions-map-path`
:   path to the genome regions map (BED format) to import

`--description-file-path`
:   path to the GWAS studies metadata file

`--init-table-path`
:   path to the initial data file to produce, default is the configured path (JASS\_DATA\_DIR/initTable.hdf5)

    Default: "/builds/statistical-genetics/jass/data/initTable.hdf5"

`--init-genetic-covariance-path`
:   path to the genetic covariance file to import. Used only for display on Jass web application

`--init-table-metadata-path`
:   path to metadata file to attache to the initial data file

### create-worktable[](#create-worktable "Permalink to this heading")

compute joint statistics for a given set of phenotypes

```
jass create-worktable [-h] [--init-table-path INIT_TABLE_PATH] --phenotypes
                      PHENOTYPES [PHENOTYPES ...] --worktable-path
                      WORKTABLE_PATH
                      [--significance-treshold SIGNIFICANCE_TRESHOLD]
                      [--post-filtering POST_FILTERING]
                      [--custom-loadings CUSTOM_LOADINGS]
                      [--csv-file-path CSV_FILE_PATH]
                      [--chunk-size CHUNK_SIZE] [--remove-nans]
                      [--chromosome-number CHROMOSOME_NUMBER]
                      [--start-position START_POSITION]
                      [--end-position END_POSITION] [--omnibus | --sumz]
```

#### Named Arguments[](#named-arguments_repeat4 "Permalink to this heading")

`--init-table-path`
:   path to the initial data table, default is the configured path (JASS\_DATA\_DIR/initTable.hdf5)

    Default: "/builds/statistical-genetics/jass/data/initTable.hdf5"

`--phenotypes`
:   list of selected phenotypes

`--worktable-path`
:   path to the worktable file to generate

`--significance-treshold`
:   threshold at which a p-value is considered significant

    Default: 5e-08

`--post-filtering`
:   If a filtering to remove outlier will be applied (in this case the result of SNPs considered aberant will not appear in the worktable)

    Default: True

`--custom-loadings`
:   path toward a csv file containing custom loading for sumZ tests

`--csv-file-path`
:   path to the results file in csv format

`--chunk-size`
:   Number of region to load in memory at once

    Default: 50

`--remove-nans`
:   Default: False

`--chromosome-number`
:   option used only for local analysis: chromosome number studied

`--start-position`
:   option used only for local analysis: start position of the region studied

`--end-position`
:   option used only for local analysis: end position of the region studied

`--omnibus`
:   Default: True

`--sumz`
:   Default: False

### plot-manhattan[](#plot-manhattan "Permalink to this heading")

generate genome-wide manhattan plot for a given set of phenotypes

```
jass plot-manhattan [-h] --worktable-path WORKTABLE_PATH --plot-path PLOT_PATH
```

#### Named Arguments[](#named-arguments_repeat5 "Permalink to this heading")

`--worktable-path`
:   path to the worktable file containing the data

`--plot-path`
:   path to the manhattan plot file to generate

### qq-plot[](#qq-plot "Permalink to this heading")

generate genome-wide qqplot of p value. Warning : require a lot of memory

```
jass qq-plot [-h] --worktable-path WORKTABLE_PATH --plot-path PLOT_PATH
```

#### Named Arguments[](#named-arguments_repeat6 "Permalink to this heading")

`--worktable-path`
:   path to the worktable file containing the data

`--plot-path`
:   path to the manhattan plot file to generate

### plot-quadrant[](#plot-quadrant "Permalink to this heading")

generate a quadrant plot for a given set of phenotypes

```
jass plot-quadrant [-h] --worktable-path WORKTABLE_PATH --plot-path PLOT_PATH
                   [--significance-treshold SIGNIFICANCE_TRESHOLD]
```

#### Named Arguments[](#named-arguments_repeat7 "Permalink to this heading")

`--worktable-path`
:   path to the worktable file containing the data

`--plot-path`
:   path to the quadrant plot file to generate

`--significance-treshold`
:   threshold at which a p-value is considered significant

    Default: 5e-08

### add-gene-annotation[](#add-gene-annotation "Permalink to this heading")

add information about genes ansd exons to the inittable

```
jass add-gene-annotation [-h] --gene-data-path GENE_DATA_PATH
                         --init-table-path INIT_TABLE_PATH
                         [--gene-csv-path GENE_CSV_PATH]
                         [--exon-csv-path EXON_CSV_PATH]
```

#### Named Arguments[](#named-arguments_repeat8 "Permalink to this heading")

`--gene-data-path`
:   path to the GFF file containing gene and exon data

`--init-table-path`
:   path to the initial table file to update

`--gene-csv-path`
:   path to the file df\_gene.csv

`--exon-csv-path`
:   path to the file df\_exon.csv

### extract-tsv[](#extract-tsv "Permalink to this heading")

Extract a table from a hdf5 repository to the tsv format. Will work for the worktables and the inittable.
WARNING: can strongly increase storage space needed

```
jass extract-tsv [-h] --hdf5-table-path HDF5_TABLE_PATH --tsv-path TSV_PATH
                 --table-key TABLE_KEY
```

#### Named Arguments[](#named-arguments_repeat9 "Permalink to this heading")

`--hdf5-table-path`
:   path to the worktable file containing the data

`--tsv-path`
:   path to the tsv table

`--table-key`
:   Existing key are 'SumStatTab' : The results of the joint analysis by SNPs - 'PhenoList' : the meta data of analysed GWAS - 'COV' : The H0 covariance used to perform joint analysis - 'GENCOV' (If present in the initTable): The genetic covariance as computed by the LDscore. Uniquely for the worktable: 'Regions' : Results of the joint analysis summarised by LD regions (Notably Lead SNPs by regions) - 'summaryTable': a double entry table summarizing the number of significant regions by test (univariate vs joint test)

### predict-gain[](#predict-gain "Permalink to this heading")

Predict gain based on the genetic architecture of the set of multi-trait. To function, this command need the inittable to contain genetic covariance store under the key 'GEN\_COV in the inittable'

```
jass predict-gain [-h] --inittable-path INITTABLE_PATH --combination-path
                  COMBINATION_PATH --gain-path GAIN_PATH
```

#### Named Arguments[](#named-arguments_repeat10 "Permalink to this heading")

`--inittable-path`
:   Path to the inittable

`--combination-path`
:   Path to the file storing combination to be scored

`--gain-path`
:   path to save predicted gain

[Previous](bibliography.html "References")
[Next](develop.html "Developer documentation")

---

© Copyright 2018, Hugues Aschard, Vi.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).