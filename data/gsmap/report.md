# gsmap CWL Generation Report

## gsmap_quick_mode

### Tool Description
Performs a quick mode analysis with gsMap.

### Metadata
- **Docker Image**: quay.io/biocontainers/gsmap:1.73.7--pyhdfd78af_0
- **Homepage**: https://github.com/LeonSong1995/gsMap
- **Package**: https://anaconda.org/channels/bioconda/packages/gsmap/overview
- **Validation**: PASS
- **tutorial**: https://yanglab.westlake.edu.cn/gps_data/website_docs/html/quick_mode.html
- **step**: https://yanglab.westlake.edu.cn/gps_data/website_docs/html/step_by_step.html
- **usage**: https://yanglab.westlake.edu.cn/gps_data/website_docs/html/advanced_usage.html
- **10x**: https://yanglab.westlake.edu.cn/gps_data/website_docs/html/10x.html
- **data**: https://yanglab.westlake.edu.cn/gps_data/website_docs/html/data_format.html
- **Conda**: https://anaconda.org/channels/bioconda/packages/gsmap/overview
- **Total Downloads**: 2.3K
- **Last updated**: 2026-02-12
- **GitHub**: https://github.com/LeonSong1995/gsMap
- **Stars**: N/A
### Original Help Text
```text
usage: gsMap quick_mode [-h] --workdir WORKDIR --sample_name SAMPLE_NAME
                        --gsMap_resource_dir GSMAP_RESOURCE_DIR --hdf5_path
                        HDF5_PATH --annotation ANNOTATION --data_layer
                        DATA_LAYER [--trait_name TRAIT_NAME]
                        [--sumstats_file SUMSTATS_FILE]
                        [--sumstats_config_file SUMSTATS_CONFIG_FILE]
                        [--homolog_file HOMOLOG_FILE]
                        [--max_processes MAX_PROCESSES]
                        [--latent_representation LATENT_REPRESENTATION]
                        [--num_neighbour NUM_NEIGHBOUR]
                        [--num_neighbour_spatial NUM_NEIGHBOUR_SPATIAL]
                        [--gM_slices GM_SLICES] [--pearson_residuals]

options:
  -h, --help            show this help message and exit
  --workdir WORKDIR     Path to the working directory. (default: None)
  --sample_name SAMPLE_NAME
                        Name of the sample. (default: None)
  --gsMap_resource_dir GSMAP_RESOURCE_DIR
                        Directory containing gsMap resources (e.g., genome
                        annotations, LD reference panel, etc.). (default:
                        None)
  --hdf5_path HDF5_PATH
                        Path to the input spatial transcriptomics data (H5AD
                        format). (default: None)
  --annotation ANNOTATION
                        Name of the annotation in adata.obs to use. (default:
                        None)
  --data_layer DATA_LAYER
                        Data layer for gene expression (e.g., "count",
                        "counts", "log1p"). (default: counts)
  --trait_name TRAIT_NAME
                        Name of the trait for GWAS analysis (required if
                        sumstats_file is provided). (default: None)
  --sumstats_file SUMSTATS_FILE
                        Path to GWAS summary statistics file. Either
                        sumstats_file or sumstats_config_file is required.
                        (default: None)
  --sumstats_config_file SUMSTATS_CONFIG_FILE
                        Path to GWAS summary statistics config file. Either
                        sumstats_file or sumstats_config_file is required.
                        (default: None)
  --homolog_file HOMOLOG_FILE
                        Path to homologous gene for converting gene names from
                        different species to human (optional, used for cross-
                        species analysis). (default: None)
  --max_processes MAX_PROCESSES
                        Maximum number of processes for parallel execution.
                        (default: 10)
  --latent_representation LATENT_REPRESENTATION
                        Type of latent representation. This should exist in
                        the h5ad obsm. (default: None)
  --num_neighbour NUM_NEIGHBOUR
                        Number of neighbors. (default: 21)
  --num_neighbour_spatial NUM_NEIGHBOUR_SPATIAL
                        Number of spatial neighbors. (default: 101)
  --gM_slices GM_SLICES
                        Path to the slice mean file (optional). (default:
                        None)
  --pearson_residuals   Using the pearson residuals. (default: False)
```


## gsmap_run_find_latent_representations

### Tool Description
Find latent representations using GAT.

### Metadata
- **Docker Image**: quay.io/biocontainers/gsmap:1.73.7--pyhdfd78af_0
- **Homepage**: https://github.com/LeonSong1995/gsMap
- **Package**: https://anaconda.org/channels/bioconda/packages/gsmap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gsMap run_find_latent_representations [-h] --workdir WORKDIR
                                             --sample_name SAMPLE_NAME
                                             --input_hdf5_path INPUT_HDF5_PATH
                                             --data_layer DATA_LAYER
                                             [--annotation ANNOTATION]
                                             [--epochs EPOCHS]
                                             [--feat_hidden1 FEAT_HIDDEN1]
                                             [--feat_hidden2 FEAT_HIDDEN2]
                                             [--gat_hidden1 GAT_HIDDEN1]
                                             [--gat_hidden2 GAT_HIDDEN2]
                                             [--p_drop P_DROP]
                                             [--gat_lr GAT_LR]
                                             [--n_neighbors N_NEIGHBORS]
                                             [--n_comps N_COMPS]
                                             [--weighted_adj]
                                             [--convergence_threshold CONVERGENCE_THRESHOLD]
                                             [--hierarchically]
                                             [--pearson_residuals]

options:
  -h, --help            show this help message and exit
  --workdir WORKDIR     Path to the working directory. (default: None)
  --sample_name SAMPLE_NAME
                        Name of the sample. (default: None)
  --input_hdf5_path INPUT_HDF5_PATH
                        Path to the input HDF5 file. (default: None)
  --data_layer DATA_LAYER
                        Data layer for gene expression (e.g., "count",
                        "counts", "log1p"). (default: counts)
  --annotation ANNOTATION
                        Name of the annotation in adata.obs to use. (default:
                        None)
  --epochs EPOCHS       Number of training epochs. (default: 300)
  --feat_hidden1 FEAT_HIDDEN1
                        Neurons in the first hidden layer. (default: 256)
  --feat_hidden2 FEAT_HIDDEN2
                        Neurons in the second hidden layer. (default: 128)
  --gat_hidden1 GAT_HIDDEN1
                        Units in the first GAT hidden layer. (default: 64)
  --gat_hidden2 GAT_HIDDEN2
                        Units in the second GAT hidden layer. (default: 30)
  --p_drop P_DROP       Dropout rate. (default: 0.1)
  --gat_lr GAT_LR       Learning rate for the GAT. (default: 0.001)
  --n_neighbors N_NEIGHBORS
                        Number of neighbors for GAT. (default: 11)
  --n_comps N_COMPS     Number of principal components for PCA. (default: 300)
  --weighted_adj        Use weighted adjacency in GAT. (default: False)
  --convergence_threshold CONVERGENCE_THRESHOLD
                        Threshold for convergence. (default: 0.0001)
  --hierarchically      Enable hierarchical latent representation finding.
                        (default: False)
  --pearson_residuals   Using the pearson residuals. (default: False)
```


## gsmap_Run

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/gsmap:1.73.7--pyhdfd78af_0
- **Homepage**: https://github.com/LeonSong1995/gsMap
- **Package**: https://anaconda.org/channels/bioconda/packages/gsmap/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: gsMap [-h] [--version]
             {quick_mode,run_find_latent_representations,run_latent_to_gene,run_generate_ldscore,run_spatial_ldsc,run_cauchy_combination,run_report,format_sumstats,create_slice_mean}
             ...
gsMap: error: argument subcommand: invalid choice: 'Run' (choose from quick_mode, run_find_latent_representations, run_latent_to_gene, run_generate_ldscore, run_spatial_ldsc, run_cauchy_combination, run_report, format_sumstats, create_slice_mean)
```


## gsmap_Find

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/gsmap:1.73.7--pyhdfd78af_0
- **Homepage**: https://github.com/LeonSong1995/gsMap
- **Package**: https://anaconda.org/channels/bioconda/packages/gsmap/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: gsMap [-h] [--version]
             {quick_mode,run_find_latent_representations,run_latent_to_gene,run_generate_ldscore,run_spatial_ldsc,run_cauchy_combination,run_report,format_sumstats,create_slice_mean}
             ...
gsMap: error: argument subcommand: invalid choice: 'Find' (choose from quick_mode, run_find_latent_representations, run_latent_to_gene, run_generate_ldscore, run_spatial_ldsc, run_cauchy_combination, run_report, format_sumstats, create_slice_mean)
```


## gsmap_run_latent_to_gene

### Tool Description
Converts latent representations to gene expression.

### Metadata
- **Docker Image**: quay.io/biocontainers/gsmap:1.73.7--pyhdfd78af_0
- **Homepage**: https://github.com/LeonSong1995/gsMap
- **Package**: https://anaconda.org/channels/bioconda/packages/gsmap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gsMap run_latent_to_gene [-h] --workdir WORKDIR --sample_name
                                SAMPLE_NAME
                                [--input_hdf5_path INPUT_HDF5_PATH]
                                [--no_expression_fraction]
                                [--latent_representation LATENT_REPRESENTATION]
                                [--num_neighbour NUM_NEIGHBOUR]
                                [--num_neighbour_spatial NUM_NEIGHBOUR_SPATIAL]
                                [--homolog_file HOMOLOG_FILE]
                                [--gM_slices GM_SLICES]
                                [--annotation ANNOTATION]

options:
  -h, --help            show this help message and exit
  --workdir WORKDIR     Path to the working directory. (default: None)
  --sample_name SAMPLE_NAME
                        Name of the sample. (default: None)
  --input_hdf5_path INPUT_HDF5_PATH
                        Path to the input HDF5 file with latent
                        representations, if --latent_representation is
                        specified. (default: None)
  --no_expression_fraction
                        Skip expression fraction filtering. (default: False)
  --latent_representation LATENT_REPRESENTATION
                        Type of latent representation. This should exist in
                        the h5ad obsm. (default: None)
  --num_neighbour NUM_NEIGHBOUR
                        Number of neighbors. (default: 21)
  --num_neighbour_spatial NUM_NEIGHBOUR_SPATIAL
                        Number of spatial neighbors. (default: 101)
  --homolog_file HOMOLOG_FILE
                        Path to homologous gene conversion file (optional).
                        (default: None)
  --gM_slices GM_SLICES
                        Path to the slice mean file (optional). (default:
                        None)
  --annotation ANNOTATION
                        Name of the annotation in adata.obs to use (optional).
                        (default: None)
```


## gsmap_Estimate

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/gsmap:1.73.7--pyhdfd78af_0
- **Homepage**: https://github.com/LeonSong1995/gsMap
- **Package**: https://anaconda.org/channels/bioconda/packages/gsmap/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: gsMap [-h] [--version]
             {quick_mode,run_find_latent_representations,run_latent_to_gene,run_generate_ldscore,run_spatial_ldsc,run_cauchy_combination,run_report,format_sumstats,create_slice_mean}
             ...
gsMap: error: argument subcommand: invalid choice: 'Estimate' (choose from quick_mode, run_find_latent_representations, run_latent_to_gene, run_generate_ldscore, run_spatial_ldsc, run_cauchy_combination, run_report, format_sumstats, create_slice_mean)
```


## gsmap_run_generate_ldscore

### Tool Description
Generate LD scores for a given sample, chromosome, and genotype data.

### Metadata
- **Docker Image**: quay.io/biocontainers/gsmap:1.73.7--pyhdfd78af_0
- **Homepage**: https://github.com/LeonSong1995/gsMap
- **Package**: https://anaconda.org/channels/bioconda/packages/gsmap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gsMap run_generate_ldscore [-h] --workdir WORKDIR --sample_name
                                  SAMPLE_NAME --chrom CHROM --bfile_root
                                  BFILE_ROOT [--keep_snp_root KEEP_SNP_ROOT]
                                  --gtf_annotation_file GTF_ANNOTATION_FILE
                                  [--gene_window_size GENE_WINDOW_SIZE]
                                  [--enhancer_annotation_file ENHANCER_ANNOTATION_FILE]
                                  [--snp_multiple_enhancer_strategy {max_mkscore,nearest_TSS}]
                                  [--gene_window_enhancer_priority {gene_window_first,enhancer_first,enhancer_only}]
                                  [--spots_per_chunk SPOTS_PER_CHUNK]
                                  [--ld_wind LD_WIND] [--ld_unit {SNP,KB,CM}]
                                  [--additional_baseline_annotation ADDITIONAL_BASELINE_ANNOTATION]

options:
  -h, --help            show this help message and exit
  --workdir WORKDIR     Path to the working directory. (default: None)
  --sample_name SAMPLE_NAME
                        Name of the sample. (default: None)
  --chrom CHROM         Chromosome id (1-22) or "all". (default: None)
  --bfile_root BFILE_ROOT
                        Root path for genotype plink bfiles (.bim, .bed,
                        .fam). (default: None)
  --keep_snp_root KEEP_SNP_ROOT
                        Root path for SNP files (default: None)
  --gtf_annotation_file GTF_ANNOTATION_FILE
                        Path to GTF annotation file. (default: None)
  --gene_window_size GENE_WINDOW_SIZE
                        Gene window size in base pairs. (default: 50000)
  --enhancer_annotation_file ENHANCER_ANNOTATION_FILE
                        Path to enhancer annotation file (optional). (default:
                        None)
  --snp_multiple_enhancer_strategy {max_mkscore,nearest_TSS}
                        Strategy for handling multiple enhancers per SNP.
                        (default: max_mkscore)
  --gene_window_enhancer_priority {gene_window_first,enhancer_first,enhancer_only}
                        Priority between gene window and enhancer annotations.
                        (default: None)
  --spots_per_chunk SPOTS_PER_CHUNK
                        Number of spots per chunk. (default: 1000)
  --ld_wind LD_WIND     LD window size. (default: 1)
  --ld_unit {SNP,KB,CM}
                        Unit for LD window. (default: CM)
  --additional_baseline_annotation ADDITIONAL_BASELINE_ANNOTATION
                        Path of additional baseline annotations (default:
                        None)
```


## gsmap_Generate

### Tool Description
gsMap: error: argument subcommand: invalid choice: 'Generate' (choose from quick_mode, run_find_latent_representations, run_latent_to_gene, run_generate_ldscore, run_spatial_ldsc, run_cauchy_combination, run_report, format_sumstats, create_slice_mean)

### Metadata
- **Docker Image**: quay.io/biocontainers/gsmap:1.73.7--pyhdfd78af_0
- **Homepage**: https://github.com/LeonSong1995/gsMap
- **Package**: https://anaconda.org/channels/bioconda/packages/gsmap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gsMap [-h] [--version]
             {quick_mode,run_find_latent_representations,run_latent_to_gene,run_generate_ldscore,run_spatial_ldsc,run_cauchy_combination,run_report,format_sumstats,create_slice_mean}
             ...
gsMap: error: argument subcommand: invalid choice: 'Generate' (choose from quick_mode, run_find_latent_representations, run_latent_to_gene, run_generate_ldscore, run_spatial_ldsc, run_cauchy_combination, run_report, format_sumstats, create_slice_mean)
```


## gsmap_run_spatial_ldsc

### Tool Description
Run spatial LDSC analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/gsmap:1.73.7--pyhdfd78af_0
- **Homepage**: https://github.com/LeonSong1995/gsMap
- **Package**: https://anaconda.org/channels/bioconda/packages/gsmap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gsMap run_spatial_ldsc [-h] --workdir WORKDIR --sample_name SAMPLE_NAME
                              --sumstats_file SUMSTATS_FILE [--w_file W_FILE]
                              --trait_name TRAIT_NAME [--n_blocks N_BLOCKS]
                              [--chisq_max CHISQ_MAX]
                              [--chunk_range CHUNK_RANGE CHUNK_RANGE]
                              [--num_processes NUM_PROCESSES]
                              [--use_additional_baseline_annotation [USE_ADDITIONAL_BASELINE_ANNOTATION]]

options:
  -h, --help            show this help message and exit
  --workdir WORKDIR     Path to the working directory. (default: None)
  --sample_name SAMPLE_NAME
                        Name of the sample. (default: None)
  --sumstats_file SUMSTATS_FILE
                        Path to GWAS summary statistics file. (default: None)
  --w_file W_FILE       Path to regression weight file. If not provided, will
                        use weights generated in the generate_ldscore step.
                        (default: None)
  --trait_name TRAIT_NAME
                        Name of the trait being analyzed. (default: None)
  --n_blocks N_BLOCKS   Number of blocks for jackknife resampling. (default:
                        200)
  --chisq_max CHISQ_MAX
                        Maximum chi-square value for filtering SNPs. (default:
                        None)
  --chunk_range CHUNK_RANGE CHUNK_RANGE
                        Range of chunks to run in this batch, omit to run all
                        chunks (default: None)
  --num_processes NUM_PROCESSES
                        Number of processes for parallel computing. (default:
                        4)
  --use_additional_baseline_annotation [USE_ADDITIONAL_BASELINE_ANNOTATION]
                        Use additional baseline annotations when provided
                        (default: True)
```


## gsmap_run_cauchy_combination

### Tool Description
Combines Cauchy results for multiple samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/gsmap:1.73.7--pyhdfd78af_0
- **Homepage**: https://github.com/LeonSong1995/gsMap
- **Package**: https://anaconda.org/channels/bioconda/packages/gsmap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gsMap run_cauchy_combination [-h] --workdir WORKDIR
                                    [--sample_name SAMPLE_NAME] --trait_name
                                    TRAIT_NAME --annotation ANNOTATION
                                    [--sample_name_list SAMPLE_NAME_LIST [SAMPLE_NAME_LIST ...]]
                                    [--output_file OUTPUT_FILE]

options:
  -h, --help            show this help message and exit
  --workdir WORKDIR     Path to the working directory. (default: None)
  --sample_name SAMPLE_NAME
                        Name of the sample. (default: None)
  --trait_name TRAIT_NAME
                        Name of the trait being analyzed. (default: None)
  --annotation ANNOTATION
                        Name of the annotation in adata.obs to use. (default:
                        None)
  --sample_name_list SAMPLE_NAME_LIST [SAMPLE_NAME_LIST ...]
                        List of sample names to process. Provide as a space-
                        separated list. (default: None)
  --output_file OUTPUT_FILE
                        Path to save the combined Cauchy results. Required
                        when using multiple samples. (default: None)
```


## gsmap_run_report

### Tool Description
Generate a report for a GWAS analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/gsmap:1.73.7--pyhdfd78af_0
- **Homepage**: https://github.com/LeonSong1995/gsMap
- **Package**: https://anaconda.org/channels/bioconda/packages/gsmap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gsMap run_report [-h] --workdir WORKDIR --sample_name SAMPLE_NAME
                        --trait_name TRAIT_NAME --annotation ANNOTATION
                        [--top_corr_genes TOP_CORR_GENES]
                        [--selected_genes [SELECTED_GENES ...]]
                        --sumstats_file SUMSTATS_FILE [--fig_width FIG_WIDTH]
                        [--fig_height FIG_HEIGHT] [--point_size POINT_SIZE]
                        [--fig_style {dark,light}]

options:
  -h, --help            show this help message and exit
  --workdir WORKDIR     Path to the working directory. (default: None)
  --sample_name SAMPLE_NAME
                        Name of the sample. (default: None)
  --trait_name TRAIT_NAME
                        Name of the trait to generate the report for.
                        (default: None)
  --annotation ANNOTATION
                        Annotation layer name. (default: None)
  --top_corr_genes TOP_CORR_GENES
                        Number of top correlated genes to display. (default:
                        50)
  --selected_genes [SELECTED_GENES ...]
                        List of specific genes to include in the report
                        (optional). (default: None)
  --sumstats_file SUMSTATS_FILE
                        Path to GWAS summary statistics file. (default: None)
  --fig_width FIG_WIDTH
                        Width of the generated figures in pixels. (default:
                        None)
  --fig_height FIG_HEIGHT
                        Height of the generated figures in pixels. (default:
                        None)
  --point_size POINT_SIZE
                        Point size for the figures. (default: None)
  --fig_style {dark,light}
                        Style of the generated figures. (default: light)
```


## gsmap_format_sumstats

### Tool Description
Format GWAS summary statistics for use with gsMap.

### Metadata
- **Docker Image**: quay.io/biocontainers/gsmap:1.73.7--pyhdfd78af_0
- **Homepage**: https://github.com/LeonSong1995/gsMap
- **Package**: https://anaconda.org/channels/bioconda/packages/gsmap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gsMap format_sumstats [-h] --sumstats SUMSTATS --out OUT [--snp SNP]
                             [--a1 A1] [--a2 A2] [--info INFO] [--beta BETA]
                             [--se SE] [--p P] [--frq FRQ] [--n N] [--z Z]
                             [--OR OR] [--se_OR SE_OR] [--chr CHR] [--pos POS]
                             [--dbsnp DBSNP] [--chunksize CHUNKSIZE]
                             [--format {gsMap,COJO}] [--info_min INFO_MIN]
                             [--maf_min MAF_MIN] [--keep_chr_pos]

options:
  -h, --help            show this help message and exit
  --sumstats SUMSTATS   Path to gwas summary data (default: None)
  --out OUT             Path to save the formatted gwas data (default: None)
  --snp SNP             Name of snp column (if not a name that gsMap
                        understands) (default: None)
  --a1 A1               Name of effect allele column (if not a name that gsMap
                        understands) (default: None)
  --a2 A2               Name of none-effect allele column (if not a name that
                        gsMap understands) (default: None)
  --info INFO           Name of info column (if not a name that gsMap
                        understands) (default: None)
  --beta BETA           Name of gwas beta column (if not a name that gsMap
                        understands). (default: None)
  --se SE               Name of gwas standar error of beta column (if not a
                        name that gsMap understands) (default: None)
  --p P                 Name of p-value column (if not a name that gsMap
                        understands) (default: None)
  --frq FRQ             Name of A1 ferquency column (if not a name that gsMap
                        understands) (default: None)
  --n N                 Name of sample size column (if not a name that gsMap
                        understands) (default: None)
  --z Z                 Name of gwas Z-statistics column (if not a name that
                        gsMap understands) (default: None)
  --OR OR               Name of gwas OR column (if not a name that gsMap
                        understands) (default: None)
  --se_OR SE_OR         Name of standar error of OR column (if not a name that
                        gsMap understands) (default: None)
  --chr CHR             Name of SNP chromosome column (if not a name that
                        gsMap understands) (default: Chr)
  --pos POS             Name of SNP positions column (if not a name that gsMap
                        understands) (default: Pos)
  --dbsnp DBSNP         Path to reference dnsnp file (default: None)
  --chunksize CHUNKSIZE
                        Chunk size for loading dbsnp file (default: 1000000.0)
  --format {gsMap,COJO}
                        Format of output data (default: gsMap)
  --info_min INFO_MIN   Minimum INFO score. (default: 0.9)
  --maf_min MAF_MIN     Minimum MAF. (default: 0.01)
  --keep_chr_pos        Keep SNP chromosome and position columns in the output
                        data (default: False)
```


## gsmap_create_slice_mean

### Tool Description
Calculates the mean expression for each slice across specified samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/gsmap:1.73.7--pyhdfd78af_0
- **Homepage**: https://github.com/LeonSong1995/gsMap
- **Package**: https://anaconda.org/channels/bioconda/packages/gsmap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gsMap create_slice_mean [-h] --sample_name_list SAMPLE_NAME_LIST
                               [SAMPLE_NAME_LIST ...]
                               [--h5ad_list H5AD_LIST [H5AD_LIST ...]]
                               [--h5ad_yaml H5AD_YAML]
                               --slice_mean_output_file SLICE_MEAN_OUTPUT_FILE
                               [--homolog_file HOMOLOG_FILE] --data_layer
                               DATA_LAYER

options:
  -h, --help            show this help message and exit
  --sample_name_list SAMPLE_NAME_LIST [SAMPLE_NAME_LIST ...]
                        List of sample names to process. Provide as a space-
                        separated list. (default: None)
  --h5ad_list H5AD_LIST [H5AD_LIST ...]
                        List of h5ad file paths corresponding to the sample
                        names. Provide as a space-separated list. (default:
                        None)
  --h5ad_yaml H5AD_YAML
                        Path to the YAML file containing sample names and
                        associated h5ad file paths (default: None)
  --slice_mean_output_file SLICE_MEAN_OUTPUT_FILE
                        Path to the output file for the slice mean (default:
                        None)
  --homolog_file HOMOLOG_FILE
                        Path to homologous gene conversion file (optional).
                        (default: None)
  --data_layer DATA_LAYER
                        Data layer for gene expression (e.g., "count",
                        "counts", "log1p"). (default: counts)
```


## Metadata
- **Skill**: generated
