# scenicplus CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| scenicplus_AUCell | Failed | image problem: running the command fails with ModuleNotFoundError: No module named 'mudata' |
| scenicplus_TF_to_gene | Failed | image problem: running the command fails with ModuleNotFoundError: No module named 'mudata' |
| scenicplus_create_scplus_mudata | Failed | image problem: running the command fails with ModuleNotFoundError: No module named 'mudata' |
| scenicplus_download_genome_annotations | Failed | image problem: running the command fails with ModuleNotFoundError: No module named 'mudata' |
| scenicplus_eGRN | Failed | image problem: running the command fails with ModuleNotFoundError: No module named 'mudata' |
| scenicplus_init_snakemake | Failed | image problem: running the command fails with ModuleNotFoundError: No module named 'mudata' |
| scenicplus_motif_enrichment_cistarget | Failed | image problem: running the command fails with ModuleNotFoundError: No module named 'mudata' |
| scenicplus_motif_enrichment_dem | Failed | image problem: running the command fails with ModuleNotFoundError: No module named 'mudata' |
| scenicplus_prepare_GEX_ACC | Failed | image problem: running the command fails with ModuleNotFoundError: No module named 'mudata' |
| scenicplus_prepare_menr | Failed | image problem: running the command fails with ModuleNotFoundError: No module named 'mudata' |
| scenicplus_region_to_gene | Failed | image problem: running the command fails with ModuleNotFoundError: No module named 'mudata' |
| scenicplus_search_spance | Failed | image problem: running the command fails with ModuleNotFoundError: No module named 'mudata' |

## scenicplus_init_snakemake

### Tool Description
Initialize ScenicPlus project for Snakemake

### Metadata
- **Docker Image**: quay.io/biocontainers/scenicplus:1.0a2--pyhdfd78af_0
- **Homepage**: https://github.com/aertslab/scenicplus
- **Package**: https://anaconda.org/channels/bioconda/packages/scenicplus/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/scenicplus/overview
- **Total Downloads**: 94
- **Last updated**: 2025-12-17
- **GitHub**: https://github.com/aertslab/scenicplus
- **Stars**: N/A
### Original Help Text
```text
/usr/local/lib/python3.11/site-packages/scenicplus/__init__.py:1: UserWarning: pkg_resources is deprecated as an API. See https://setuptools.pypa.io/en/latest/pkg_resources.html. The pkg_resources package is slated for removal as early as 2025-11-30. Refrain from using this package or pin to Setuptools<81.
  from pkg_resources import get_distribution, DistributionNotFound
usage: scenicplus init_snakemake [-h] --out_dir OUT_DIR
scenicplus init_snakemake: error: argument -h/--help: ignored explicit argument 'elp'
```


## scenicplus_TF_to_gene

### Tool Description
Infer TF-to-gene adjacencies with gradient boosting or random forest regression.

### Metadata
- **Docker Image**: quay.io/biocontainers/scenicplus:1.0a2--pyhdfd78af_0
- **Homepage**: https://github.com/aertslab/scenicplus
- **Package**: https://anaconda.org/channels/bioconda/packages/scenicplus/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scenicplus grn_inference TF_to_gene [-h] --multiome_mudata_fname
                                           MULTIOME_MUDATA_FNAME --tf_names
                                           TF_NAMES --temp_dir TEMP_DIR
                                           --out_tf_to_gene_adjacencies
                                           OUT_TF_TO_GENE_ADJACENCIES
                                           [--method {GBM,RF}] [--n_cpu N_CPU]
                                           [--seed SEED]

Infer TF-to-gene relationships

options:
  -h, --help            show this help message and exit
  --multiome_mudata_fname MULTIOME_MUDATA_FNAME
                        Path to multiome MuData object (from scenicplus
                        prepare_GEX_ACC).
  --tf_names TF_NAMES   Path TF names (from scenicplus prepare_menr).
  --temp_dir TEMP_DIR   Path temp dir.
  --out_tf_to_gene_adjacencies OUT_TF_TO_GENE_ADJACENCIES
                        Out file name to store TF to gene adjacencies (tsv)
  --method {GBM,RF}     Regression method to use, either GBM (Gradient
                        Boosting Machine) or RF (Random Forrest). Default is
                        GBM
  --n_cpu N_CPU         Number of cores to use. Default is 1.
  --seed SEED           Seed to use. Default is 666.
```

## scenicplus_region_to_gene

### Tool Description
Infer region-to-gene adjacencies from chromatin accessibility and gene expression.

### Metadata
- **Docker Image**: quay.io/biocontainers/scenicplus:1.0a2--pyhdfd78af_0
- **Homepage**: https://github.com/aertslab/scenicplus
- **Package**: https://anaconda.org/channels/bioconda/packages/scenicplus/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scenicplus grn_inference region_to_gene [-h] --multiome_mudata_fname
                                               MULTIOME_MUDATA_FNAME
                                               --search_space_fname
                                               SEARCH_SPACE_FNAME --temp_dir
                                               TEMP_DIR
                                               --out_region_to_gene_adjacencies
                                               OUT_REGION_TO_GENE_ADJACENCIES
                                               [--importance_scoring_method {RF,ET,GBM}]
                                               [--correlation_scoring_method {PR,SR}]
                                               [--mask_expr_dropout]
                                               [--n_cpu N_CPU]

Infer region-to-gene relationships

options:
  -h, --help            show this help message and exit
  --multiome_mudata_fname MULTIOME_MUDATA_FNAME
                        Path to multiome MuData object (from scenicplus
                        prepare_GEX_ACC).
  --search_space_fname SEARCH_SPACE_FNAME
                        Path to search space dataframe (from scenicplus
                        search_spance).
  --temp_dir TEMP_DIR   Path temp dir.
  --out_region_to_gene_adjacencies OUT_REGION_TO_GENE_ADJACENCIES
                        Path to store region to gene adjacencies (tsv).
  --importance_scoring_method {RF,ET,GBM}
                        Regression method to use, either GBM (Gradient
                        Boosting Machine), RF (Random Forrest) or ET (Extra
                        Trees). Default is GBM.
  --correlation_scoring_method {PR,SR}
                        Correlation method to use, either PR (Pearson
                        correlation) or SR (Spearman Rank correlation).
                        Default is SR.
  --mask_expr_dropout   Whether to mask expression dropouts. Default is False.
  --n_cpu N_CPU         Number of cores to use. Default is 1.
```

## scenicplus_motif_enrichment_cistarget

### Tool Description
Run motif enrichment on a set of regions using the cistarget algorithm.

### Metadata
- **Docker Image**: quay.io/biocontainers/scenicplus:1.0a2--pyhdfd78af_0
- **Homepage**: https://github.com/aertslab/scenicplus
- **Package**: https://anaconda.org/channels/bioconda/packages/scenicplus/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scenicplus grn_inference motif_enrichment_cistarget [-h]
                                                           --region_set_folder
                                                           REGION_SET_FOLDER
                                                           --cistarget_db_fname
                                                           CISTARGET_DB_FNAME
                                                           --output_fname_cistarget_result
                                                           OUTPUT_FNAME_CISTARGET_RESULT
                                                           --temp_dir TEMP_DIR
                                                           --species SPECIES
                                                           [--fr_overlap_w_ctx_db FRACTION_OVERLAP_W_CISTARGET_DATABASE]
                                                           [--auc_threshold AUC_THRESHOLD]
                                                           [--nes_threshold NES_THRESHOLD]
                                                           [--rank_threshold RANK_THRESHOLD]
                                                           [--path_to_motif_annotations PATH_TO_MOTIF_ANNOTATIONS]
                                                           [--annotation_version ANNOTATION_VERSION]
                                                           [--motif_similarity_fdr MOTIF_SIMILARITY_FDR]
                                                           [--orthologous_identity_threshold ORTHOLOGOUS_IDENTITY_THRESHOLD]
                                                           [--annotations_to_use [ANNOTATIONS_TO_USE ...]]
                                                           [--write_html]
                                                           [--output_fname_cistarget_html OUTPUT_FNAME_CISTARGET_HTML]
                                                           [--n_cpu N_CPU]

Run motif enrichment on a set of regions using the cistarget algorithm

options:
  -h, --help            show this help message and exit
  --region_set_folder REGION_SET_FOLDER
                        Path to the folder containing folders of bed files.
  --cistarget_db_fname CISTARGET_DB_FNAME
                        Path to the cisTarget rankings database
                        (.regions_vs_motifs.rankings.feather).
  --output_fname_cistarget_result OUTPUT_FNAME_CISTARGET_RESULT
                        Path to store cistarget result (.hdf5).
  --temp_dir TEMP_DIR   Path to temp dir.
  --species SPECIES     Species used for the analysis. This parameter is used
                        to download the correct motif-to-TF annotations from
                        the cisTarget webservers.
  --fr_overlap_w_ctx_db FRACTION_OVERLAP_W_CISTARGET_DATABASE
                        Fraction of nucleotides, of regions in the bed file,
                        that should overlap with regions in the cistarget
                        database in order for them to be included in the
                        analysis. Defaults to: 0.4
  --auc_threshold AUC_THRESHOLD
                        Threshold on the AUC value for calling significant
                        motifs. Defaults to: 0.005
  --nes_threshold NES_THRESHOLD
                        Threshold on the NES value for calling significant
                        motifs. NES - Normalised Enrichment Score - is defined
                        as (AUC - Avg(AUC)) / sd(AUC). Defaults to: 3.0
  --rank_threshold RANK_THRESHOLD
                        The total number of ranked regions to take into
                        account when creating a recovery curves. Defaults to:
                        0.05
  --path_to_motif_annotations PATH_TO_MOTIF_ANNOTATIONS
                        Path to the motif-to-TF annotations. By default this
                        will be downloaded from the cisTarget webservers.
  --annotation_version ANNOTATION_VERSION
                        Version of the motif-to-TF annotation to use. This
                        parameter is used to download the correct motif-to-TF
                        data from the cisTarget webservers. Defaults to:
                        v10nr_clust
  --motif_similarity_fdr MOTIF_SIMILARITY_FDR
                        " Threshold on motif similarity scores for calling
                        similar motifs. Defaults to: 0.001
  --orthologous_identity_threshold ORTHOLOGOUS_IDENTITY_THRESHOLD
                        Threshold on the protein-protein orthology score for
                        calling orthologous motifs. Defaults to: 0.0
  --annotations_to_use [ANNOTATIONS_TO_USE ...]
                        Which annotations to use for annotation motifs to TFs.
                        Defaults to: Direct_annot Motif_similarity_annot
                        Orthology_annot
  --write_html          Wether or not to save the results as an html file.
  --output_fname_cistarget_html OUTPUT_FNAME_CISTARGET_HTML
                        Path to store cistarget result html (.html), only if
                        --write_html.
  --n_cpu N_CPU         Number of cores to use. Default is 1.
```

## scenicplus_motif_enrichment_dem

### Tool Description
Run motif enrichment on a set of regions using the differential enrichment of motifs (DEM) algorithm.

### Metadata
- **Docker Image**: quay.io/biocontainers/scenicplus:1.0a2--pyhdfd78af_0
- **Homepage**: https://github.com/aertslab/scenicplus
- **Package**: https://anaconda.org/channels/bioconda/packages/scenicplus/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scenicplus grn_inference motif_enrichment_dem [-h] --region_set_folder
                                                     REGION_SET_FOLDER
                                                     --dem_db_fname
                                                     DEM_DB_FNAME
                                                     --output_fname_dem_result
                                                     OUTPUT_FNAME_DEM_RESULT
                                                     --temp_dir TEMP_DIR
                                                     --species SPECIES
                                                     [--fraction_overlap_w_dem_database FRACTION_OVERLAP_W_DEM_DATABASE]
                                                     [--max_bg_regions MAX_BG_REGIONS]
                                                     [--genome_annotation GENOME_ANNOTATION]
                                                     [--balance_number_of_promoters]
                                                     [--promoter_space PROMOTER_SPACE]
                                                     [--adjpval_thr ADJPVAL_THR]
                                                     [--log2fc_thr LOG2FC_THR]
                                                     [--mean_fg_thr MEAN_FG_THR]
                                                     [--motif_hit_thr MOTIF_HIT_THR]
                                                     [--path_to_motif_annotations PATH_TO_MOTIF_ANNOTATIONS]
                                                     [--annotation_version ANNOTATION_VERSION]
                                                     [--motif_similarity_fdr MOTIF_SIMILARITY_FDR]
                                                     [--orthologous_identity_threshold ORTHOLOGOUS_IDENTITY_THRESHOLD]
                                                     [--annotations_to_use [ANNOTATIONS_TO_USE ...]]
                                                     [--write_html]
                                                     [--output_fname_dem_html OUTPUT_FNAME_DEM_HTML]
                                                     [--seed SEED]
                                                     [--n_cpu N_CPU]

Run motif enrichment on a set of regions using the DEM algorithm

options:
  -h, --help            show this help message and exit
  --region_set_folder REGION_SET_FOLDER
                        Path to the folder containing folders of bed files.
  --dem_db_fname DEM_DB_FNAME
                        Path to the DEM score database
                        (.regions_vs_motifs.scores.feather).
  --output_fname_dem_result OUTPUT_FNAME_DEM_RESULT
                        Path to store dem result (.hdf5).
  --temp_dir TEMP_DIR   Path to temp dir.
  --species SPECIES     Species used for the analysis. This parameter is used
                        to download the correct motif-to-TF annotations from
                        the cisTarget webservers.
  --fraction_overlap_w_dem_database FRACTION_OVERLAP_W_DEM_DATABASE
                        Fraction of nucleotides, of regions in the bed file,
                        that should overlap with regions in the dem database
                        in order for them to be included in the analysis.
                        Defaults to: 0.4
  --max_bg_regions MAX_BG_REGIONS
                        Maximum number of regions to use as background.
                        Defaults to None (i.e. use all regions)
  --genome_annotation GENOME_ANNOTATION
                        Path to genome annotation. This parameter is required
                        whe balance_number_of_promoters is set. Defaults to
                        None.
  --balance_number_of_promoters
                        Set this flag to balance the number of promoter
                        regions in fore- and background. When this is set a
                        genome annotation must be provided using the
                        --genome_annotation parameter.
  --promoter_space PROMOTER_SPACE
                        Number of basepairs up- and downstream of the TSS that
                        are considered as being the promoter for that gene.
                        Defaults to: 1000
  --adjpval_thr ADJPVAL_THR
                        Threshold on the Benjamini-Hochberg adjusted p-value
                        from the Wilcoxon test performed on the motif score of
                        foreground vs background regions for a motif to be
                        considered as enriched. Defaults to: 0.05
  --log2fc_thr LOG2FC_THR
                        Threshold on the log2 fold change of the motif score
                        of foreground vs background regions for a motif to be
                        considered as enriched. Defaults to: 1.0
  --mean_fg_thr MEAN_FG_THR
                        Minimul mean signal in the foreground to consider a
                        motif enriched. Defaults to: 0.0
  --motif_hit_thr MOTIF_HIT_THR
                        Minimal CRM score to consider a region enriched for a
                        motif. Default: None (It will be automatically
                        calculated based on precision-recall).
  --path_to_motif_annotations PATH_TO_MOTIF_ANNOTATIONS
                        Path to the motif-to-TF annotations. By default this
                        will be downloaded from the cisTarget webservers.
  --annotation_version ANNOTATION_VERSION
                        Version of the motif-to-TF annotation to use. This
                        parameter is used to download the correct motif-to-TF
                        data from the cisTarget webservers. Defaults to:
                        v10nr_clust
  --motif_similarity_fdr MOTIF_SIMILARITY_FDR
                        " Threshold on motif similarity scores for calling
                        similar motifs. Defaults to: 0.001
  --orthologous_identity_threshold ORTHOLOGOUS_IDENTITY_THRESHOLD
                        Threshold on the protein-protein orthology score for
                        calling orthologous motifs. Defaults to: 0.0
  --annotations_to_use [ANNOTATIONS_TO_USE ...]
                        Which annotations to use for annotation motifs to TFs.
                        Defaults to: Direct_annot Motif_similarity_annot
                        Orthology_annot
  --write_html          Wether or not to save the results as an html file.
  --output_fname_dem_html OUTPUT_FNAME_DEM_HTML
                        Path to store dem result html (.html), only if
                        --write_html.
  --seed SEED           Random seed use for sampling background regions (if
                        max_bg_regions is not None) Defaults to: 555
  --n_cpu N_CPU         Number of cores to use. Default is 1.
```

## scenicplus_eGRN

### Tool Description
Infer enhancer-driven gene regulatory networks (eRegulons).

### Metadata
- **Docker Image**: quay.io/biocontainers/scenicplus:1.0a2--pyhdfd78af_0
- **Homepage**: https://github.com/aertslab/scenicplus
- **Package**: https://anaconda.org/channels/bioconda/packages/scenicplus/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scenicplus grn_inference eGRN [-h] --TF_to_gene_adj_fname
                                     TF_TO_GENE_ADJ_FNAME
                                     --region_to_gene_adj_fname
                                     REGION_TO_GENE_ADJ_FNAME
                                     --cistromes_fname CISTROMES_FNAME
                                     --ranking_db_fname RANKING_DB_FNAME
                                     --eRegulon_out_fname EREGULON_OUT_FNAME
                                     --temp_dir TEMP_DIR [--is_extended]
                                     [--order_regions_to_genes_by ORDER_REGIONS_TO_GENES_BY]
                                     [--order_TFs_to_genes_by ORDER_TFS_TO_GENES_BY]
                                     [--gsea_n_perm GSEA_N_PERM]
                                     [--quantiles [QUANTILES ...]]
                                     [--top_n_regionTogenes_per_gene [TOP_N_REGIONTOGENES_PER_GENE ...]]
                                     [--top_n_regionTogenes_per_region [TOP_N_REGIONTOGENES_PER_REGION ...]]
                                     [--do_not_binarize_using_basc]
                                     [--min_regions_per_gene MIN_REGIONS_PER_GENE]
                                     [--do_not_rho_dichotomize_tf2g]
                                     [--do_not_rho_dichotomize_r2g]
                                     [--do_not_rho_dichotomize_eRegulon]
                                     [--keep_only_activating_eRegulons]
                                     [--rho_threshold RHO_THRESHOLD]
                                     [--min_target_genes MIN_TARGET_GENES]
                                     [--n_cpu N_CPU] [--seed SEED]

Infer enhancer-driven Gene Regulatory Network (eGRN)

options:
  -h, --help            show this help message and exit
  --TF_to_gene_adj_fname TF_TO_GENE_ADJ_FNAME
                        Path to TF-to-gene adjacencies (.tsv) from scenicplus
                        TF_to_gene.
  --region_to_gene_adj_fname REGION_TO_GENE_ADJ_FNAME
                        Path to region-to-gene adjacencies (.tsv) from
                        scenicplus region_to_gene.
  --cistromes_fname CISTROMES_FNAME
                        Path to either direct or extended cistromes (.h5ad)
                        from scenicplus prepare_menr.
  --ranking_db_fname RANKING_DB_FNAME
                        Path to cistarget ranking database, this should be the
                        same database as used for motif enrichment analysis
                        using pyCistarget (.feather)
  --eRegulon_out_fname EREGULON_OUT_FNAME
                        Path to save eRegulon dataframe (.tsv)
  --temp_dir TEMP_DIR   Path to temp dir.
  --is_extended         Use this when cistromes are based on extended
                        annotation. Default is False.
  --order_regions_to_genes_by ORDER_REGIONS_TO_GENES_BY
                        Column by which to order the region-to-gene links.
                        Default is 'importance'.
  --order_TFs_to_genes_by ORDER_TFS_TO_GENES_BY
                        Column by which to order the TF-to-gene links. Default
                        is 'importance'.
  --gsea_n_perm GSEA_N_PERM
                        Number of permutations to run for GSEA. Default is
                        1000.
  --quantiles [QUANTILES ...]
                        Quantiles for thresholding region-to-gene links.
                        Default is [0.85, 0.90, 0.95]
  --top_n_regionTogenes_per_gene [TOP_N_REGIONTOGENES_PER_GENE ...]
                        Top n region-to-gene links per gene for thresholding
                        region-to-gene links. Default is [5, 10, 15]
  --top_n_regionTogenes_per_region [TOP_N_REGIONTOGENES_PER_REGION ...]
                        Top n region-to-gene links per region for thresholding
                        region-to-gene links. Default is []
  --do_not_binarize_using_basc
                        Don't use BASC to binarize region to gene links. By
                        default BASC is used.
  --min_regions_per_gene MIN_REGIONS_PER_GENE
                        Minimum regions per gene. Default is 0.
  --do_not_rho_dichotomize_tf2g
                        Don't split positive and negative TF-to-gene links. By
                        default they are split.
  --do_not_rho_dichotomize_r2g
                        Don't split positive and negative region-to-gene
                        links. By default they are split.
  --do_not_rho_dichotomize_eRegulon
                        Don't split positive and negative eRegulons. By
                        default they are split.
  --keep_only_activating_eRegulons
                        Keep only activating eRegulons. By default both
                        activating and repressive eRegulons are kept.
  --rho_threshold RHO_THRESHOLD
                        Threshold on correlation coefficient used for
                        splitting positive and negative interactions. Default
                        is 0.05
  --min_target_genes MIN_TARGET_GENES
                        Minimum number of target genes per eRegulon, eRegulon
                        with a lower number of target genes will be discarded.
                        Default is 10
  --n_cpu N_CPU         Number of cores to use. Default is 1.
  --seed SEED           Seed to use. Default is 666.
```

## scenicplus_AUCell

### Tool Description
Calculate eRegulon enrichment scores using AUCell.

### Metadata
- **Docker Image**: quay.io/biocontainers/scenicplus:1.0a2--pyhdfd78af_0
- **Homepage**: https://github.com/aertslab/scenicplus
- **Package**: https://anaconda.org/channels/bioconda/packages/scenicplus/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scenicplus grn_inference AUCell [-h] --eRegulon_fname EREGULON_FNAME
                                       --multiome_mudata_fname
                                       MULTIOME_MUDATA_FNAME
                                       --aucell_out_fname AUCELL_OUT_FNAME
                                       [--n_cpu N_CPU]

Calculate eRegulon enrichment scores using AUCell

options:
  -h, --help            show this help message and exit
  --eRegulon_fname EREGULON_FNAME
                        Path to eRegulons (.tsv) from scenicplus eGRN.
  --multiome_mudata_fname MULTIOME_MUDATA_FNAME
                        Path to multiome mudata (.h5mu) from scenicplus
                        prepare_GEX_ACC.
  --aucell_out_fname AUCELL_OUT_FNAME
                        Path to store enrichment scores (.h5mu).
  --n_cpu N_CPU         Number of cores to use. Default is 1.
```

## scenicplus_create_scplus_mudata

### Tool Description
Create the final SCENIC+ MuData object from eRegulon AUC values and metadata.

### Metadata
- **Docker Image**: quay.io/biocontainers/scenicplus:1.0a2--pyhdfd78af_0
- **Homepage**: https://github.com/aertslab/scenicplus
- **Package**: https://anaconda.org/channels/bioconda/packages/scenicplus/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scenicplus grn_inference create_scplus_mudata [-h]
                                                     --multiome_mudata_fname
                                                     MULTIOME_MUDATA_FNAME
                                                     --e_regulon_auc_direct_mudata_fname
                                                     E_REGULON_AUC_DIRECT_MUDATA_FNAME
                                                     --e_regulon_auc_extended_mudata_fname
                                                     E_REGULON_AUC_EXTENDED_MUDATA_FNAME
                                                     --e_regulon_metadata_direct_fname
                                                     E_REGULON_METADATA_DIRECT_FNAME
                                                     --e_regulon_metadata_extended_fname
                                                     E_REGULON_METADATA_EXTENDED_FNAME
                                                     --out_file OUT_FILE

Create MuData object to store SCENIC+ results. Can be used for downstream
analysis.

options:
  -h, --help            show this help message and exit
  --multiome_mudata_fname MULTIOME_MUDATA_FNAME
                        Path to MuData containing gene expression and
                        chromatin accessibility data (.h5mu)
  --e_regulon_auc_direct_mudata_fname E_REGULON_AUC_DIRECT_MUDATA_FNAME
                        Path to MuData containing AUC values for direct
                        eRegulons (.h5mu)
  --e_regulon_auc_extended_mudata_fname E_REGULON_AUC_EXTENDED_MUDATA_FNAME
                        Path to MuData containing AUC values for extended
                        eRegulons (.h5mu)
  --e_regulon_metadata_direct_fname E_REGULON_METADATA_DIRECT_FNAME
                        Path to tsv containing metadata for direct eRegulons
                        (.tsv)
  --e_regulon_metadata_extended_fname E_REGULON_METADATA_EXTENDED_FNAME
                        Path to tsv containing metadata for extended eRegulons
                        (.tsv)
  --out_file OUT_FILE   Path to store resulting MuData (.h5mu)
```

## scenicplus_prepare_GEX_ACC

### Tool Description
Prepare scRNA-seq and scATAC-seq data. Returns a MuData file containing linked gene expression and chromatin accessibility data.

### Metadata
- **Docker Image**: quay.io/biocontainers/scenicplus:1.0a2--pyhdfd78af_0
- **Homepage**: https://github.com/aertslab/scenicplus
- **Package**: https://anaconda.org/channels/bioconda/packages/scenicplus/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scenicplus prepare_data prepare_GEX_ACC [-h] --cisTopic_obj_fname
                                               CISTOPIC_OBJ_FNAME
                                               --GEX_anndata_fname
                                               GEX_ANNDATA_FNAME --out_file
                                               OUT_FILE
                                               [--do_not_use_raw_for_GEX_anndata]
                                               [--is_not_multiome]
                                               [--bc_transform_func BC_TRANSFORM_FUNC]
                                               [--key_to_group_by KEY_TO_GROUP_BY]
                                               [--nr_metacells NR_METACELLS]
                                               [--nr_cells_per_metacells NR_CELLS_PER_METACELLS]

Prepare scRNA-seq, scATAC-seq data. Returns a MuData file containing linked
gene expression and chromatin accessibility data.

options:
  -h, --help            show this help message and exit
  --cisTopic_obj_fname CISTOPIC_OBJ_FNAME
                        Path to cisTopic object pickle file.
  --GEX_anndata_fname GEX_ANNDATA_FNAME
                        Path to gene expression AnnData h5ad file.
  --out_file OUT_FILE   Out file name (MuData h5mu file).
  --do_not_use_raw_for_GEX_anndata
                        Do not use raw gene expression counts. Default is
                        False
  --is_not_multiome     Data is not multiome. Default is False
  --bc_transform_func BC_TRANSFORM_FUNC
                        lambda function to transform gene expression cell
                        barcodes into chromatin accessibility barcodes.
                        Default is lambda x: x
  --key_to_group_by KEY_TO_GROUP_BY
                        For non multi_ome_mode, use this cell metadata key to
                        generate metacells from scRNA-seq and scATAC-seq. Key
                        should be common in scRNA-seq and scATAC-seq side.
  --nr_metacells NR_METACELLS
                        For non multi_ome_mode, use this number of meta cells
                        to link scRNA-seq and scATAC-seq If this is a single
                        integer the same number of metacells will be used for
                        all annotations. By default this number is determined
                        automatically so that each cell is sampled at maximum
                        twice.
  --nr_cells_per_metacells NR_CELLS_PER_METACELLS
                        For non multi_ome_mode, use this number of cells per
                        metacell to link scRNA-seq and scATAC-seq. If this is
                        a single integer the same number of cells will be used
                        for all annotations. Default is 10
```

## scenicplus_prepare_menr

### Tool Description
Prepare motif enrichment results: creates cistromes and the list of TF names.

### Metadata
- **Docker Image**: quay.io/biocontainers/scenicplus:1.0a2--pyhdfd78af_0
- **Homepage**: https://github.com/aertslab/scenicplus
- **Package**: https://anaconda.org/channels/bioconda/packages/scenicplus/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scenicplus prepare_data prepare_menr [-h]
                                            --paths_to_motif_enrichment_results
                                            PATHS_TO_MOTIF_ENRICHMENT_RESULTS
                                            [PATHS_TO_MOTIF_ENRICHMENT_RESULTS ...]
                                            --multiome_mudata_fname
                                            MULTIOME_MUDATA_FNAME
                                            --out_file_tf_names
                                            OUT_FILE_TF_NAMES
                                            [--out_file_direct_annotation OUT_FILE_DIRECT_ANNOTATION]
                                            [--out_file_extended_annotation OUT_FILE_EXTENDED_ANNOTATION]
                                            [--direct_annotation DIRECT_ANNOTATION [DIRECT_ANNOTATION ...]]
                                            [--extended_annotation EXTENDED_ANNOTATION [EXTENDED_ANNOTATION ...]]

Prepare motif enrichment data. Returns two AnnData files containing cistroms
based on direct and extended motif-to-TF annotations. Also updates the
multiome MuData indicating which genes are TFs.

options:
  -h, --help            show this help message and exit
  --paths_to_motif_enrichment_results PATHS_TO_MOTIF_ENRICHMENT_RESULTS [PATHS_TO_MOTIF_ENRICHMENT_RESULTS ...]
                        Paths to motif enrichment result hdf5 files (from
                        pycistarget).
  --multiome_mudata_fname MULTIOME_MUDATA_FNAME
                        Path to multiome MuData object (from scenicplus
                        prepare_GEX_ACC).
  --out_file_tf_names OUT_FILE_TF_NAMES
                        Out file name for TF names (txt file).
  --out_file_direct_annotation OUT_FILE_DIRECT_ANNOTATION
                        Out file name for direct cistromes (AnnData h5ad
                        file).
  --out_file_extended_annotation OUT_FILE_EXTENDED_ANNOTATION
                        Out file name for extended cistromes (AnnData h5ad
                        file).
  --direct_annotation DIRECT_ANNOTATION [DIRECT_ANNOTATION ...]
                        Annotations to use as direct. Default is
                        'Direct_annot'
  --extended_annotation EXTENDED_ANNOTATION [EXTENDED_ANNOTATION ...]
                        Annotations to use as extended. Default is
                        'Orthology_annot'
```

## scenicplus_download_genome_annotations

### Tool Description
Download genome annotation and chromosome sizes from BioMart.

### Metadata
- **Docker Image**: quay.io/biocontainers/scenicplus:1.0a2--pyhdfd78af_0
- **Homepage**: https://github.com/aertslab/scenicplus
- **Package**: https://anaconda.org/channels/bioconda/packages/scenicplus/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scenicplus prepare_data download_genome_annotations [-h] --species
                                                           SPECIES
                                                           --genome_annotation_out_fname
                                                           GENOME_ANNOTATION_OUT_FNAME
                                                           --chromsizes_out_fname
                                                           CHROMSIZES_OUT_FNAME
                                                           [--biomart_host BIOMART_HOST]
                                                           [--do_not_use_ucsc_chromosome_style]

Download genome annotation and chromsizes and save to tsv

options:
  -h, --help            show this help message and exit
  --species SPECIES     Species name (e.g. hsapies).
  --genome_annotation_out_fname GENOME_ANNOTATION_OUT_FNAME
                        Out file name for genome annotation (tsv).
  --chromsizes_out_fname CHROMSIZES_OUT_FNAME
                        Out file name for chromosome sizes (tsv).
  --biomart_host BIOMART_HOST
                        Biomart host name
  --do_not_use_ucsc_chromosome_style
                        Do not use UCSC chromosome style names.
```

## scenicplus_search_spance

### Tool Description
Define the search space around each gene for the region-to-gene links.

### Metadata
- **Docker Image**: quay.io/biocontainers/scenicplus:1.0a2--pyhdfd78af_0
- **Homepage**: https://github.com/aertslab/scenicplus
- **Package**: https://anaconda.org/channels/bioconda/packages/scenicplus/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scenicplus prepare_data search_spance [-h] --multiome_mudata_fname
                                             MULTIOME_MUDATA_FNAME
                                             --gene_annotation_fname
                                             GENE_ANNOTATION_FNAME
                                             --chromsizes_fname
                                             CHROMSIZES_FNAME --out_fname
                                             OUT_FNAME [--use_gene_boundaries]
                                             [--upstream UPSTREAM UPSTREAM]
                                             [--downstream DOWNSTREAM DOWNSTREAM]
                                             [--extend_tss EXTEND_TSS EXTEND_TSS]
                                             [--remove_promoters]

Get search space for each gene. Returns tsv with search spance

options:
  -h, --help            show this help message and exit
  --multiome_mudata_fname MULTIOME_MUDATA_FNAME
                        Path to multiome MuData object (from scenicplus
                        prepare_GEX_ACC).
  --gene_annotation_fname GENE_ANNOTATION_FNAME
                        Path to gene annotation tsv (from scenicplus
                        download_genome_annotations).
  --chromsizes_fname CHROMSIZES_FNAME
                        Path to chromosome sizes tsv (from scenicplus
                        download_genome_annotations).
  --out_fname OUT_FNAME
                        Out file name for gene search space (tsv).
  --use_gene_boundaries
                        Whether to use the whole search space or stop when
                        encountering another gene.
  --upstream UPSTREAM UPSTREAM
                        Search space upstream. The minimum (first position)
                        means that even if there is a gene right next to it
                        these bp will be taken. The second position indicates
                        the maximum distance. Default is 1000 150000
  --downstream DOWNSTREAM DOWNSTREAM
                        Search space downstream. The minimum (first position)
                        means that even if there is a gene right next to it
                        these bp will be taken. The second position indicates
                        the maximum distance. Default is 1000 150000
  --extend_tss EXTEND_TSS EXTEND_TSS
                        Space around the TSS consider as promoter. Default is
                        10 10
  --remove_promoters    Whether to remove promoters from the search space or
                        not.
```

## Metadata
- **Skill**: not generated
