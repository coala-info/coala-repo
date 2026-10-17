# pyclone CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| pyclone_build_mutations_file | PASS |  |
| pyclone_build_table | PASS |  |
| pyclone_plot_clusters | PASS |  |
| pyclone_plot_loci | PASS |  |
| pyclone_run_analysis | PASS |  |
| pyclone_run_analysis_pipeline | PASS |  |
| pyclone_setup_analysis | PASS |  |

## pyclone_build_mutations_file

### Tool Description
Build a YAML format file with mutation data and states prior to be used for PyClone analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyclone:0.13.1--py_0
- **Homepage**: https://github.com/Roth-Lab/pyclone
- **Package**: https://anaconda.org/channels/bioconda/packages/pyclone/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PyClone build_mutations_file [-h] --in_file IN_FILE --out_file OUT_FILE
                                    [--prior {major_copy_number,parental_copy_number,total_copy_number}]

optional arguments:
  -h, --help            show this help message and exit
  --in_file IN_FILE     Path to tab separated input file. The input file
                        should have header and the following columns:
                        mutation_id, ref_counts, var_counts, normal_cn,
                        minor_cn, major_cn. Any additional columns will be
                        ignored. See examples for format.
  --out_file OUT_FILE   Path where YAML formatted PyClone input file will be
                        written.
  --prior {major_copy_number,parental_copy_number,total_copy_number}
                        Method used to set the possible genotypes. See online
                        help for description. Default is major_copy_number.
```

## pyclone_build_table

### Tool Description
Build results table which contains cluster ids and (mean) cellular prevalence estimates.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyclone:0.13.1--py_0
- **Homepage**: https://github.com/Roth-Lab/pyclone
- **Package**: https://anaconda.org/channels/bioconda/packages/pyclone/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PyClone build_table [-h] --config_file CONFIG_FILE --out_file OUT_FILE
                           --table_type {cluster,loci,old_style}
                           [--max_clusters MAX_CLUSTERS]
                           [--mesh_size MESH_SIZE] [--burnin BURNIN]
                           [--thin THIN]

optional arguments:
  -h, --help            show this help message and exit
  --config_file CONFIG_FILE
                        Path to configuration file used for analysis.
  --out_file OUT_FILE   Path where table will be written in tsv format.
  --table_type {cluster,loci,old_style}
                        Build a table of results. Choices are: `cluster` for
                        cluster specific information; `loci` for loci specific
                        information; `old_style` matches the 0.12.x PyClone
                        output.
  --max_clusters MAX_CLUSTERS
                        Maximum number of clusters to consider for post-
                        processing. Note this does not affect the DP sampling
                        only the final post-processing steps to get hard
                        cluster assignments.
  --mesh_size MESH_SIZE
                        Number of points to use for approximating the cluster
                        posteriors. Default is 101.
  --burnin BURNIN       Number of samples to discard as burning for the MCMC
                        chain. Default is 0.
  --thin THIN           Number of samples to thin MCMC trace. For example if
                        thin=10 every tenth sample after burning will be used
                        for inference. Default is 1.
```

## pyclone_plot_clusters

### Tool Description
Plot features of the clusters.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyclone:0.13.1--py_0
- **Homepage**: https://github.com/Roth-Lab/pyclone
- **Package**: https://anaconda.org/channels/bioconda/packages/pyclone/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PyClone plot_clusters [-h] --config_file CONFIG_FILE --plot_file
                             PLOT_FILE --plot_type
                             {density,parallel_coordinates,scatter}
                             [--burnin BURNIN] [--thin THIN]
                             [--max_clusters MAX_CLUSTERS]
                             [--mesh_size MESH_SIZE]
                             [--min_cluster_size MIN_CLUSTER_SIZE]
                             [--samples SAMPLES [SAMPLES ...]]

optional arguments:
  -h, --help            show this help message and exit
  --config_file CONFIG_FILE
                        Path to configuration file used for analysis.
  --plot_file PLOT_FILE
                        Path to file where plot will be saved. Format can be
                        controlled by changing file extension.
  --plot_type {density,parallel_coordinates,scatter}
                        Determines which style of plot will be done.
  --burnin BURNIN       Number of samples to discard as burning for the MCMC
                        chain. Default is 0.
  --thin THIN           Number of samples to thin MCMC trace. For example if
                        thin=10 every tenth sample after burning will be used
                        for inference. Default is 1.
  --max_clusters MAX_CLUSTERS
                        Maximum number of clusters to consider for post-
                        processing. Note this does not affect the DP sampling
                        only the final post-processing steps to get hard
                        cluster assignments.
  --mesh_size MESH_SIZE
                        Number of points to use for approximating the cluster
                        posteriors. Default is 101.
  --min_cluster_size MIN_CLUSTER_SIZE
                        Clusters with fewer mutations than this value will not
                        be plotted.
  --samples SAMPLES [SAMPLES ...]
                        Samples to plot and order to plot them in.
```

## pyclone_plot_loci

### Tool Description
Plot features of the loci.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyclone:0.13.1--py_0
- **Homepage**: https://github.com/Roth-Lab/pyclone
- **Package**: https://anaconda.org/channels/bioconda/packages/pyclone/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PyClone plot_loci [-h] --config_file CONFIG_FILE --plot_file PLOT_FILE
                         --plot_type
                         {density,parallel_coordinates,scatter,similarity_matrix,vaf_parallel_coordinates,vaf_scatter}
                         [--burnin BURNIN] [--thin THIN]
                         [--min_cluster_size MIN_CLUSTER_SIZE]
                         [--max_clusters MAX_CLUSTERS]
                         [--samples SAMPLES [SAMPLES ...]]

optional arguments:
  -h, --help            show this help message and exit
  --config_file CONFIG_FILE
                        Path to configuration file used for analysis.
  --plot_file PLOT_FILE
                        Path to file where plot will be saved. Format can be
                        controlled by changing file extension.
  --plot_type {density,parallel_coordinates,scatter,similarity_matrix,vaf_parallel_coordinates,vaf_scatter}
                        Determines which style of plot will be done.
  --burnin BURNIN       Number of samples to discard as burning for the MCMC
                        chain. Default is 0.
  --thin THIN           Number of samples to thin MCMC trace. For example if
                        thin=10 every tenth sample after burning will be used
                        for inference. Default is 1.
  --min_cluster_size MIN_CLUSTER_SIZE
                        Clusters with fewer mutations than this value will not
                        be plotted.
  --max_clusters MAX_CLUSTERS
                        Maximum number of clusters to consider for post-
                        processing. Note this does not affect the DP sampling
                        only the final post-processing steps to get hard
                        cluster assignments.
  --samples SAMPLES [SAMPLES ...]
                        Samples to plot and order to plot them in.
```

## pyclone_run_analysis

### Tool Description
Run an MCMC sampler to sample from the posterior of the PyClone model.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyclone:0.13.1--py_0
- **Homepage**: https://github.com/Roth-Lab/pyclone
- **Package**: https://anaconda.org/channels/bioconda/packages/pyclone/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PyClone run_analysis [-h] --config_file CONFIG_FILE [--seed SEED]

optional arguments:
  -h, --help            show this help message and exit
  --config_file CONFIG_FILE
                        Path to configuration file used for analysis.
  --seed SEED           Set random seed so results can be reproduced. By
                        default a random seed is chosen.
```

## pyclone_run_analysis_pipeline

### Tool Description
Run a full PyClone analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyclone:0.13.1--py_0
- **Homepage**: https://github.com/Roth-Lab/pyclone
- **Package**: https://anaconda.org/channels/bioconda/packages/pyclone/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PyClone run_analysis_pipeline [-h] --in_files IN_FILES [IN_FILES ...]
                                     --working_dir WORKING_DIR
                                     [--tumour_contents TUMOUR_CONTENTS [TUMOUR_CONTENTS ...]]
                                     [--samples SAMPLES [SAMPLES ...]]
                                     [--config_extras_file CONFIG_EXTRAS_FILE]
                                     [--density {pyclone_binomial,pyclone_beta_binomial}]
                                     [--init_method {connected,disconnected}]
                                     [--num_iters NUM_ITERS]
                                     [--prior {major_copy_number,parental_copy_number,total_copy_number}]
                                     [--burnin BURNIN] [--thin THIN]
                                     [--seed SEED]
                                     [--plot_file_format {pdf,svg}]
                                     [--max_clusters MAX_CLUSTERS]
                                     [--mesh_size MESH_SIZE]
                                     [--min_cluster_size MIN_CLUSTER_SIZE]

optional arguments:
  -h, --help            show this help message and exit
  --in_files IN_FILES [IN_FILES ...]
                        Space delimited list of tsv format files with copy
                        number and allele count information. See
                        build_mutations_file command for information.
  --working_dir WORKING_DIR
                        Path of directory where analysis pipeline files will
                        be placed.
  --tumour_contents TUMOUR_CONTENTS [TUMOUR_CONTENTS ...]
                        Space delimited list of tumour contents. Should match
                        the order of --in_files. If not given tumour content
                        is assumed to 1.0 in all samples.
  --samples SAMPLES [SAMPLES ...]
                        Space delimited list of sample names. Should be in the
                        same order as --in_files. If not set sample name will
                        be inferred from file names and ordering in plots will
                        be arbitrary.
  --config_extras_file CONFIG_EXTRAS_FILE
                        Path to configuration file with extra parameters used
                        for analysis.
  --density {pyclone_binomial,pyclone_beta_binomial}
                        Emission density for the model. Default is
                        pyclone_beta_binomial.
  --init_method {connected,disconnected}
                        How to initialise the DP clustering algorithm.
                        `connected` places all data points in one cluster,
                        preferred for large datasets. `disconnected places
                        each data point in a separate cluster. Default
                        `disconnected`.
  --num_iters NUM_ITERS
                        Number of iterations of the MCMC sampler to perform.
                        Default is 10,000.
  --prior {major_copy_number,parental_copy_number,total_copy_number}
                        Method used to set the possible genotypes. See online
                        help for description. Default is major_copy_number.
  --burnin BURNIN       Number of samples to discard as burning for the MCMC
                        chain. Default is 0.
  --thin THIN           Number of samples to thin MCMC trace. For example if
                        thin=10 every tenth sample after burning will be used
                        for inference. Default is 1.
  --seed SEED           Set random seed so results can be reproduced. By
                        default a random seed is chosen.
  --plot_file_format {pdf,svg}
                        File format for plots. Default is pdf.
  --max_clusters MAX_CLUSTERS
                        Maximum number of clusters to consider for post-
                        processing. Note this does not affect the DP sampling
                        only the final post-processing steps to get hard
                        cluster assignments.
  --mesh_size MESH_SIZE
                        Number of points to use for approximating the cluster
                        posteriors. Default is 101.
  --min_cluster_size MIN_CLUSTER_SIZE
                        Clusters with fewer mutations than this value will not
                        be plotted.
```

## pyclone_setup_analysis

### Tool Description
Setup a config file and mutations files for a PyClone analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyclone:0.13.1--py_0
- **Homepage**: https://github.com/Roth-Lab/pyclone
- **Package**: https://anaconda.org/channels/bioconda/packages/pyclone/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PyClone setup_analysis [-h] --in_files IN_FILES [IN_FILES ...]
                              --working_dir WORKING_DIR
                              [--tumour_contents TUMOUR_CONTENTS [TUMOUR_CONTENTS ...]]
                              [--samples SAMPLES [SAMPLES ...]]
                              [--config_extras_file CONFIG_EXTRAS_FILE]
                              [--density {pyclone_binomial,pyclone_beta_binomial}]
                              [--init_method {connected,disconnected}]
                              [--num_iters NUM_ITERS]
                              [--prior {major_copy_number,parental_copy_number,total_copy_number}]

optional arguments:
  -h, --help            show this help message and exit
  --in_files IN_FILES [IN_FILES ...]
                        Space delimited list of tsv format files with copy
                        number and allele count information. See
                        build_mutations_file command for information.
  --working_dir WORKING_DIR
                        Path of directory where analysis pipeline files will
                        be placed.
  --tumour_contents TUMOUR_CONTENTS [TUMOUR_CONTENTS ...]
                        Space delimited list of tumour contents. Should match
                        the order of --in_files. If not given tumour content
                        is assumed to 1.0 in all samples.
  --samples SAMPLES [SAMPLES ...]
                        Space delimited list of sample names. Should be in the
                        same order as --in_files. If not set sample name will
                        be inferred from file names and ordering in plots will
                        be arbitrary.
  --config_extras_file CONFIG_EXTRAS_FILE
                        Path to configuration file with extra parameters used
                        for analysis.
  --density {pyclone_binomial,pyclone_beta_binomial}
                        Emission density for the model. Default is
                        pyclone_beta_binomial.
  --init_method {connected,disconnected}
                        How to initialise the DP clustering algorithm.
                        `connected` places all data points in one cluster,
                        preferred for large datasets. `disconnected places
                        each data point in a separate cluster. Default
                        `disconnected`.
  --num_iters NUM_ITERS
                        Number of iterations of the MCMC sampler to perform.
                        Default is 10,000.
  --prior {major_copy_number,parental_copy_number,total_copy_number}
                        Method used to set the possible genotypes. See online
                        help for description. Default is major_copy_number.
```

