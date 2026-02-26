# metaquantome CWL Generation Report

## metaquantome_db

### Tool Description
metaQuantome uses freely available bioinformatic databases to expand your set of direct annotations. For most cases, all 3 databases can be downloaded (the default).

### Metadata
- **Docker Image**: quay.io/biocontainers/metaquantome:2.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/galaxyproteomics/metaquant
- **Package**: https://anaconda.org/channels/bioconda/packages/metaquantome/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/metaquantome/overview
- **Total Downloads**: 29.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/galaxyproteomics/metaquant
- **Stars**: N/A
### Original Help Text
```text
usage: metaquantome db [-h] [--dir DIR] [--update]
                       {ncbi,go,ec} [{ncbi,go,ec} ...]

metaQuantome uses freely available bioinformatic databases to expand your set of direct annotations. For most cases, all 3 databases can be downloaded (the default).
The databases are:
1. NCBI taxonomy database. This contains a list of all currently identified taxa and the relationships between them.
2. Gene Ontology (GO) term database. metaQuantome uses the OBO format of the database. Specifically, two files are used: the go-basic.obo file, which is a simplified version of the GO database that is guaranteed to be acyclic, and the metagenomics slim GO, which is a subset of the full GO that is useful for microbiome research. More details are available at http://geneontology.org/docs/download-ontology/
3. ENZYME database with Enzyme Classification (EC) numbers. This database classifies enzymes and organizes the relationships between them.
This module downloads the most recent releases of the specified databases and stores them in a single file, which can then be accessed by the rest of the metaQuantome modules. For reference, the taxonomy database is the largest (~500 Mb), while the GO and EC databases are smaller: ~34 Mb and ~10Mb, respectively.

positional arguments:
  {ncbi,go,ec}       database to download. note that COG mode does not require a download due to its simplicity.

optional arguments:
  -h, --help         show this help message and exit
  --dir DIR, -d DIR  data directory for files.
  --update, -u       overwrite existing databases if present.
```


## metaquantome_expand

### Tool Description
The expand module is the first analysis step in the metaQuantome analysis workflow, and can be run to analyze function, taxonomy, or function and taxonomy together.

### Metadata
- **Docker Image**: quay.io/biocontainers/metaquantome:2.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/galaxyproteomics/metaquant
- **Package**: https://anaconda.org/channels/bioconda/packages/metaquantome/overview
- **Validation**: PASS

### Original Help Text
```text
usage: metaquantome expand [-h] --samps SAMPS --mode {f,t,ft}
                           [--ontology {go,cog,ec}] [--data_dir DATA_DIR]
                           [--nopep] [--nopep_file NOPEP_FILE]
                           [--int_file INT_FILE]
                           [--pep_colname_int PEP_COLNAME_INT]
                           [--pep_colname_func PEP_COLNAME_FUNC]
                           [--pep_colname_tax PEP_COLNAME_TAX] --outfile
                           OUTFILE [--func_file FUNC_FILE]
                           [--func_colname FUNC_COLNAME] [--slim_down]
                           [--overwrite] [--tax_file TAX_FILE]
                           [--tax_colname TAX_COLNAME]
                           [--ft_tar_rank FT_TAR_RANK]

The expand module is the first analysis step in the metaQuantome analysis workflow, and can be run to analyze function, taxonomy, or function and taxonomy together.
To prepare to run this module, you must create your samples file (tabular file with `group` and `colnames` columns with each row as a sample group) and download the necessary databases with `metaquantome db`.
Some example analysis workflows are:
1. Get the functional, taxonomic, or functional-taxonomic distribution: run expand, filter, and viz.
2. Cluster analysis: run expand, filter, and viz. The viz module has heatmaps and PCA plots for cluster analysis.
3. Differential expression: run expand, filter, stat, and viz.

The following information is required for all 3 analysis modes (function, taxonomy, and function-taxonomy).
- experimental design information.
- a tab-separated peptide intensity file.
- the name of the peptide column in the intensity file.

Function mode
In function mode, the following information is required:
- the ontology being used: Gene Ontology (GO), Clusters of Orthologous Groups (COG), or Enzyme Commission (EC) numbers.
- a tab-separated functional annotation file, with a peptide column and a functional annotation column. An entry in the functional annotation column may contain multiple functional annotations separated by commas.
- the name of the peptide column in the functional annotation file.
- the name of the functional annotation column in the functional annotation file.

Taxonomy mode
In taxonomy mode, the following information is required:
- a tab-separated taxonomy annotation file, with a peptide column and a taxonomy annotation column. The taxonomic annotations should be the lowest common ancestor (LCA) for each peptide, preferably given as NCBI taxonomy IDs.
- the name of the peptide column in the taxonomic annotation file.
- the name of the taxonomy annotation column in the taxonomy annotation file.

Function-Taxonomy mode
In the combined mode, all of the above must be provided. In addition, the "target rank" must be provided, which is the desired taxonomic rank at which to summarize the function/taxonomy results.

optional arguments:
  -h, --help            show this help message and exit

Arguments common to all modules.:
  --samps SAMPS, -s SAMPS
                        Give the column names in the intensity file that correspond to a given sample group. This can either be JSON formatted or be a path to a tabular file. JSON example of two experimental groups and two samples in each group: {"A": ["A1", "A2"], "B": ["B1", "B2"]}

Arguments for all analyses:
  --mode {f,t,ft}, -m {f,t,ft}
                        Analysis mode. If ft is chosen, both function and taxonomy files must be provided
  --ontology {go,cog,ec}
                        Which functional terms to use. Ignored (and not required) if mode is not f or ft.
  --data_dir DATA_DIR   Path to data directory. The default is <metaquantome_pkg_dir>/data

Arguments for all 3 modes:
  --nopep               If provided, need to provide a --nopep_file.
  --nopep_file NOPEP_FILE
                        File with functional or taxonomic annotations and intensities. 
  --int_file INT_FILE, -i INT_FILE
                        Path to the file with intensity data. Must be tabular, have a peptide sequence column, and be raw, untransformed intensity values. Missing values can be 0, NA, or NaN- transformed to NA for modules
  --pep_colname_int PEP_COLNAME_INT
                        The column name within the intensity file that corresponds to the peptide sequences. 
  --pep_colname_func PEP_COLNAME_FUNC
                        The column name within the function file that corresponds to the peptide sequences. 
  --pep_colname_tax PEP_COLNAME_TAX
                        The column name within the taxonomy file that corresponds to the peptide sequences. 
  --outfile OUTFILE     Output file

Function:
  --func_file FUNC_FILE, -f FUNC_FILE
                        Path to file with function. The file must be tabular, with a peptide sequence column and either a GO-term column, COG column, or EC number column. The name of the functional column should be given in --func_colname. Other columns will be ignored. 
  --func_colname FUNC_COLNAME
                        Name of the functional column
  --slim_down           Flag. If provided, terms are mapped from the full OBO to the slim OBO. Terms not in the full OBO will be skipped.
  --overwrite           Flag. The most relevant database (GO or EC) is downloaded to data_dir, overwriting any previously downloaded databases at these locations.

Taxonomy:
  --tax_file TAX_FILE, -t TAX_FILE
                        Path to (tabular) file with taxonomy assignments. There should be a peptide sequence column with name pep_colname, and a taxonomy column with name tax_colname
  --tax_colname TAX_COLNAME
                        Name of taxonomy column in tax file. The column must be either NCBI taxids (strongly preferred) or taxonomy names. Unipept name output is known to function well, but other formats may not work.

Function-Taxonomy:
  --ft_tar_rank FT_TAR_RANK
                        Desired rank for taxonomy. The default is 'genus'.
```


## metaquantome_filter

### Tool Description
The filter module is the second step in the metaQuantome analysis workflow. The purpose of the filter module is to filter expanded terms to those that are representative and well-supported by the data. Please see the manuscript (https://doi.org/10.1074/mcp.ra118.001240) for further details about filtering.

### Metadata
- **Docker Image**: quay.io/biocontainers/metaquantome:2.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/galaxyproteomics/metaquant
- **Package**: https://anaconda.org/channels/bioconda/packages/metaquantome/overview
- **Validation**: PASS

### Original Help Text
```text
usage: metaquantome filter [-h] --samps SAMPS --mode {f,t,ft}
                           [--ontology {go,cog,ec}] [--data_dir DATA_DIR]
                           [--expand_file EXPAND_FILE]
                           [--min_peptides MIN_PEPTIDES]
                           [--min_pep_nsamp MIN_PEP_NSAMP]
                           [--min_children_non_leaf MIN_CHILDREN_NON_LEAF]
                           [--min_child_nsamp MIN_CHILD_NSAMP]
                           [--qthreshold QTHRESHOLD] --outfile OUTFILE

The filter module is the second step in the metaQuantome analysis workflow. The purpose of the filter module is to filter expanded terms to those that are representative and well-supported by the data. Please see the manuscript (https://doi.org/10.1074/mcp.ra118.001240) for further details about filtering.

optional arguments:
  -h, --help            show this help message and exit
  --expand_file EXPAND_FILE
                        Output from metaquantome expand.
  --min_peptides MIN_PEPTIDES
                        Used for filtering to well-supported annotations. The number of peptides providing evidence for a term is the number of peptides directly annotated with that term plus the number of peptides annotated with any of its descendants. Terms with a number of peptides greater than or equal to min_peptides are retained. The default is 0.
  --min_pep_nsamp MIN_PEP_NSAMP
                        Number of samples per group that must meet or exceed min_peptides. Can either be a nonnegative integer or 'all'.
  --min_children_non_leaf MIN_CHILDREN_NON_LEAF
                        Used for filtering to informative annotations. A term is retained if it has a number of children greater than or equal to min_children_non_leaf. The default is 0. 
  --min_child_nsamp MIN_CHILD_NSAMP
                        Number of samples per group that must meet or exceed min_children_nsamp. Can either be a nonnegative integer or 'all'.
  --qthreshold QTHRESHOLD
                        Minimum number of intensities in each sample group. Any functional/taxonomic term with lower number of per-group intensities will be filtered out. The default is 3, because this is the minimum number for t-tests.
  --outfile OUTFILE     Output file

Arguments common to all modules.:
  --samps SAMPS, -s SAMPS
                        Give the column names in the intensity file that correspond to a given sample group. This can either be JSON formatted or be a path to a tabular file. JSON example of two experimental groups and two samples in each group: {"A": ["A1", "A2"], "B": ["B1", "B2"]}

Arguments for all analyses:
  --mode {f,t,ft}, -m {f,t,ft}
                        Analysis mode. If ft is chosen, both function and taxonomy files must be provided
  --ontology {go,cog,ec}
                        Which functional terms to use. Ignored (and not required) if mode is not f or ft.
  --data_dir DATA_DIR   Path to data directory. The default is <metaquantome_pkg_dir>/data
```


## metaquantome_stat

### Tool Description
The stat module is the third step in the metaQuantome analysis workflow. The purpose of the stat module is to perform differential expression analysis between 2 experimental conditions. metaQuantome offers paired and unpaired tests, as well as parametric and non-parametric options.

### Metadata
- **Docker Image**: quay.io/biocontainers/metaquantome:2.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/galaxyproteomics/metaquant
- **Package**: https://anaconda.org/channels/bioconda/packages/metaquantome/overview
- **Validation**: PASS

### Original Help Text
```text
usage: metaquantome stat [-h] --samps SAMPS --mode {f,t,ft}
                         [--ontology {go,cog,ec}] [--data_dir DATA_DIR] --file
                         FILE --outfile OUTFILE [--parametric PARAMETRIC]
                         [--paired] --control_group CONTROL_GROUP

The stat module is the third step in the metaQuantome analysis workflow. The purpose of the stat module is to perform differential expression analysis between 2 experimental conditions. metaQuantome offers paired and unpaired tests, as well as parametric and non-parametric options.

optional arguments:
  -h, --help            show this help message and exit
  --file FILE, -f FILE  Output file from metaquantome expand.
  --outfile OUTFILE     Output file
  --parametric PARAMETRIC
                        Choose the type of test. If --parametric True is provided,then a standard t-test is performed. If --parametric False (the default) is provided, then a Wilcoxon test is performed.
  --paired              Perform paired tests.
  --control_group CONTROL_GROUP
                        Sample group name of control samples (will be used as denominator for fold change).

Arguments common to all modules.:
  --samps SAMPS, -s SAMPS
                        Give the column names in the intensity file that correspond to a given sample group. This can either be JSON formatted or be a path to a tabular file. JSON example of two experimental groups and two samples in each group: {"A": ["A1", "A2"], "B": ["B1", "B2"]}

Arguments for all analyses:
  --mode {f,t,ft}, -m {f,t,ft}
                        Analysis mode. If ft is chosen, both function and taxonomy files must be provided
  --ontology {go,cog,ec}
                        Which functional terms to use. Ignored (and not required) if mode is not f or ft.
  --data_dir DATA_DIR   Path to data directory. The default is <metaquantome_pkg_dir>/data
```


## metaquantome_viz

### Tool Description
The viz module is the final step in the metaQuantome analysis workflow. The available visualizations are:
-bar plot
-volcano plot
-heatmap
-PCA plot
Please consult the manuscript (https://doi.org/10.1074/mcp.ra118.001240.) for full details on each of these plots.

### Metadata
- **Docker Image**: quay.io/biocontainers/metaquantome:2.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/galaxyproteomics/metaquant
- **Package**: https://anaconda.org/channels/bioconda/packages/metaquantome/overview
- **Validation**: PASS

### Original Help Text
```text
usage: metaquantome viz [-h] --samps SAMPS --mode {f,t,ft}
                        [--ontology {go,cog,ec}] [--data_dir DATA_DIR]
                        --plottype
                        {bar,volcano,heatmap,pca,ft_dist,stacked_bar} --img
                        IMG [--width WIDTH] [--height HEIGHT] --infile INFILE
                        [--strip STRIP] [--tabfile TABFILE]
                        [--fc_corr_p FC_CORR_P] [--meancol MEANCOL]
                        [--nterms NTERMS] [--barcol BARCOL]
                        [--target_rank TARGET_RANK] [--target_onto {mf,bp,cc}]
                        [--whichway {f_dist,t_dist}] [--name NAME] [--id ID]
                        [--fc_name FC_NAME] [--textannot TEXTANNOT]
                        [--gosplit] [--flip_fc] [--filter_to_sig]
                        [--alpha ALPHA]
                        [--feature_cluster_size FEATURE_CLUSTER_SIZE]
                        [--sample_cluster_size SAMPLE_CLUSTER_SIZE]
                        [--calculate_sep]

The viz module is the final step in the metaQuantome analysis workflow. The available visualizations are:
-bar plot
-volcano plot
-heatmap
-PCA plot
Please consult the manuscript (https://doi.org/10.1074/mcp.ra118.001240.) for full details on each of these plots.

optional arguments:
  -h, --help            show this help message and exit
  --plottype {bar,volcano,heatmap,pca,ft_dist,stacked_bar}, -p {bar,volcano,heatmap,pca,ft_dist,stacked_bar}
                        Select the type of plot to generate.
  --img IMG             Path to the PNG image file (must end in ".png").
  --width WIDTH         Width of the image in inches. Defaults vary by plot type.
  --height HEIGHT       Height of the image in inches. Defaults vary by plot type.
  --infile INFILE, -i INFILE
                        Input file from stat or filter.
  --strip STRIP         Text to remove from column names for plotting.
  --tabfile TABFILE     Optional. File to write plot table to.
  --fc_corr_p FC_CORR_P
                        Name of the corrected p-value column in the stat dataframe. Used while generating volcano plot and while using filter_to_sig in heatmap

Arguments common to all modules.:
  --samps SAMPS, -s SAMPS
                        Give the column names in the intensity file that correspond to a given sample group. This can either be JSON formatted or be a path to a tabular file. JSON example of two experimental groups and two samples in each group: {"A": ["A1", "A2"], "B": ["B1", "B2"]}

Arguments for all analyses:
  --mode {f,t,ft}, -m {f,t,ft}
                        Analysis mode. If ft is chosen, both function and taxonomy files must be provided
  --ontology {go,cog,ec}
                        Which functional terms to use. Ignored (and not required) if mode is not f or ft.
  --data_dir DATA_DIR   Path to data directory. The default is <metaquantome_pkg_dir>/data

Arguments for barplots - including total taxonomy peptide intensity ("bar"), function-taxonomy interaction distributions ("ft_dist"), and stacked taxonomy bar plots ("stacked_bar"):
  --meancol MEANCOL     (Tax bar and FT dist). Mean intensity column name for desired experimental conditio.
  --nterms NTERMS       (Tax bar, FT dist, and stacked bar). Number of taxa or functional terms to display. The default is 5.
  --barcol BARCOL       (Tax bar and FT dist). Color for the bar fill. The color vector in R is c("dodgerblue", "darkorange", "yellow2", "red2", "darkviolet", "black"),  so providing a 1 will give the "dodgerblue" color. These same colors are also used in the  heatmap and PCA plot, so the colors can be tweaked to match. 
  --target_rank TARGET_RANK
                        (Tax bar, FT dist, and stacked bar). Taxonomic rank to restrict to in the plot. 
  --target_onto {mf,bp,cc}
                        (Function and FT dist bar only) Ontology to restrict to, for function distribution.
  --whichway {f_dist,t_dist}
                        (FT dist only) Which distribution - functional distribution for a taxon (f_dist) or taxonomic distribution for a function (t_dist)?
  --name NAME           (FT dist only) Provide either a taxonomic or functional term name. Either provide this or an --id.
  --id ID               (FT dist bar only) Taxonomic or functional term id - either a NCBI taxID or a GO term id (GO:XXXXXXX)

Volcano Plot:
  --fc_name FC_NAME     Name of the fold change column in the stat dataframe.
  --textannot TEXTANNOT
                        Name of the text annotation column to optionally include in the volcano. If missing, no text will be plotted. 
  --gosplit             If using GO terms, whether to make one plot for each of BP, CC, and MF.
  --flip_fc             Flag. Whether to flip the fold change (i.e., multiply log fold change by -1)

Heatmap:
  --filter_to_sig       Flag. Only plot significant terms? Necessitates use of results from `test`.
  --alpha ALPHA         If filter_to_sig, the q-value significance level.
  --feature_cluster_size FEATURE_CLUSTER_SIZE
                        Number of clusters 'k' to cut the feature dendrogram tree. Default = 2
  --sample_cluster_size SAMPLE_CLUSTER_SIZE
                        Number of clusters 'k' to cut the sample dendrogram tree. Default = 2

Principal Components Analysis:
  --calculate_sep       Flag. Calculate separation between groups and include in title?
```


## Metadata
- **Skill**: generated

## metaquantome

### Tool Description
metaQuantome is a tool that performs quantitative analysis on the function and taxonomy of microbomes and their interactions. For more background information, please read the associated manuscript: https://doi.org/10.1074/mcp.ra118.001240. For a more hands-on tutorial, please visit the following page: https://galaxyproteomics.github.io/metaquantome_mcp_analysis/cli_tutorial/cli_tutorial.html.

The metaQuantome workflow is as follows: db → expand → filter → stat → viz.

Run `metaquantome {db,expand,filter,stat,viz} -h` for more information on the individual modules. Any issues can be brought to attention here: https://github.com/galaxyproteomics/metaquantome/issues.

### Metadata
- **Docker Image**: quay.io/biocontainers/metaquantome:2.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/galaxyproteomics/metaquant
- **Package**: https://anaconda.org/channels/bioconda/packages/metaquantome/overview
- **Validation**: PASS
### Original Help Text
```text
usage: metaquantome [-h] [-v] {db,expand,filter,stat,viz} ...

metaQuantome is a tool that performs quantitative analysis on the function and taxonomy of microbomes and their interactions. For more background information, please read the associated manuscript: https://doi.org/10.1074/mcp.ra118.001240. For a more hands-on tutorial, please visit the following page: https://galaxyproteomics.github.io/metaquantome_mcp_analysis/cli_tutorial/cli_tutorial.html.

The metaQuantome workflow is as follows: db → expand → filter → stat → viz.

Run `metaquantome {db,expand,filter,stat,viz} -h` for more information on the individual modules. Any issues can be brought to attention here: https://github.com/galaxyproteomics/metaquantome/issues.

optional arguments:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit

commands:
  {db,expand,filter,stat,viz}
```

