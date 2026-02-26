# pycistarget CWL Generation Report

## pycistarget_cistarget

### Tool Description
Run motif enrichment analysis using the cisTarget algorithm.

### Metadata
- **Docker Image**: quay.io/biocontainers/pycistarget:1.1--pyhdfd78af_0
- **Homepage**: https://github.com/aertslab/pycistarget
- **Package**: https://anaconda.org/channels/bioconda/packages/pycistarget/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pycistarget/overview
- **Total Downloads**: 113
- **Last updated**: 2025-11-06
- **GitHub**: https://github.com/aertslab/pycistarget
- **Stars**: N/A
### Original Help Text
```text
usage: pycistarget cistarget [-h] --cistarget_db_fname CISTARGET_DB_FNAME
                             --bed_fname BED_FNAME --output_folder
                             OUTPUT_FOLDER --species SPECIES
                             [--fr_overlap_w_ctx_db FRACTION_OVERLAP_W_CISTARGET_DATABASE]
                             [--auc_threshold AUC_THRESHOLD]
                             [--nes_threshold NES_THRESHOLD]
                             [--rank_threshold RANK_THRESHOLD]
                             [--path_to_motif_annotations PATH_TO_MOTIF_ANNOTATIONS]
                             [--annotation_version ANNOTATION_VERSION]
                             [--motif_similarity_fdr MOTIF_SIMILARITY_FDR]
                             [--orthologous_identity_threshold ORTHOLOGOUS_IDENTITY_THRESHOLD]
                             [--annotations_to_use [ANNOTATIONS_TO_USE ...]]
                             [--name NAME] [--output_mode {tsv,hdf5,hdf5+}]
                             [--write_html]

Run motif enrichment analysis using the cisTarget algorithm.

options:
  -h, --help            show this help message and exit
  --cistarget_db_fname CISTARGET_DB_FNAME
                        Path to the cisTarget rankings database
                        (.regions_vs_motifs.rankings.feather).
  --bed_fname BED_FNAME
                        Path to bed file on which to run motif enrichment
                        analysis.
  --output_folder OUTPUT_FOLDER
                        Path to the folder in which to write results.
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
  --name NAME           Name of this analysis. This name is appended to the
                        output file name. By default the file name of the bed
                        file is used.
  --output_mode {tsv,hdf5,hdf5+}
                        Specifies how the results will be saved to disk. tsv:
                        tab-seperated text file containing which motifs are
                        enriched. hdf5: a new hdf5 file will be created
                        containing the full results. hdf5+: an existing hdf5
                        file will be appended with the full motifs enrichment
                        results. Defaults to 'hdf5'
  --write_html          Wether or not to save the results as an html file.
```


## pycistarget_dem

### Tool Description
dem

### Metadata
- **Docker Image**: quay.io/biocontainers/pycistarget:1.1--pyhdfd78af_0
- **Homepage**: https://github.com/aertslab/pycistarget
- **Package**: https://anaconda.org/channels/bioconda/packages/pycistarget/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pycistarget dem [-h] --dem_db_fname DEM_DB_FNAME --foreground_beds
                       FOREGROUND_BEDS [FOREGROUND_BEDS ...] --background_beds
                       BACKGROUND_BEDS [BACKGROUND_BEDS ...] --output_folder
                       OUTPUT_FOLDER --species SPECIES
                       [--fraction_overlap_w_dem_database FRACTION_OVERLAP_W_DEM_DATABASE]
                       [--max_bg_regions MAX_BG_REGIONS]
                       [--genome_annotation GENOME_ANNOTATION]
                       [--balance_number_of_promoters]
                       [--promoter_space PROMOTER_SPACE]
                       [--adjpval_thr ADJPVAL_THR] [--log2fc_thr LOG2FC_THR]
                       [--mean_fg_thr MEAN_FG_THR]
                       [--motif_hit_thr MOTIF_HIT_THR]
                       [--path_to_motif_annotations PATH_TO_MOTIF_ANNOTATIONS]
                       [--annotation_version ANNOTATION_VERSION]
                       [--motif_similarity_fdr MOTIF_SIMILARITY_FDR]
                       [--orthologous_identity_threshold ORTHOLOGOUS_IDENTITY_THRESHOLD]
                       [--annotations_to_use [ANNOTATIONS_TO_USE ...]]
                       [--name NAME] [--output_mode {tsv,hdf5,hdf5+}]
                       [--write_html] [--seed SEED]

dem

options:
  -h, --help            show this help message and exit
  --dem_db_fname DEM_DB_FNAME
                        Path to the DEM score database
                        (.regions_vs_motifs.scores.feather).
  --foreground_beds FOREGROUND_BEDS [FOREGROUND_BEDS ...]
                        Path(s) to bed file(s) to use as foreground regions.
  --background_beds BACKGROUND_BEDS [BACKGROUND_BEDS ...]
                        Path(s) to bed file(s) to use as background regions.
  --output_folder OUTPUT_FOLDER
                        Path to the folder in which to write results.
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
  --name NAME           Name of this analysis. This name is appended to the
                        output file name. By default the file name of the bed
                        file is used.
  --output_mode {tsv,hdf5,hdf5+}
                        Specifies how the results will be saved to disk. tsv:
                        tab-seperated text file containing which motifs are
                        enriched. hdf5: a new hdf5 file will be created
                        containing the full results. hdf5+: an existing hdf5
                        file will be appended with the full motifs enrichment
                        results. Defaults to 'hdf5'
  --write_html          Wether or not to save the results as an html file.
  --seed SEED           Random seed use for sampling background regions (if
                        max_bg_regions is not None) Defaults to: 555
```

