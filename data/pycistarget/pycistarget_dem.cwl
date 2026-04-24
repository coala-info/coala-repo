cwlVersion: v1.2
class: CommandLineTool
baseCommand: pycistarget dem
label: pycistarget_dem
doc: "dem\n\nTool homepage: https://github.com/aertslab/pycistarget"
inputs:
  - id: background_beds
    type:
      type: array
      items: File
    doc: Path(s) to bed file(s) to use as background regions.
    inputBinding:
      position: 1
  - id: foreground_beds
    type:
      type: array
      items: File
    doc: Path(s) to bed file(s) to use as foreground regions.
    inputBinding:
      position: 2
  - id: adjpval_thr
    type:
      - 'null'
      - float
    doc: "Threshold on the Benjamini-Hochberg adjusted p-value\n                 \
      \       from the Wilcoxon test performed on the motif score of\n           \
      \             foreground vs background regions for a motif to be\n         \
      \               considered as enriched."
    inputBinding:
      position: 103
      prefix: --adjpval_thr
  - id: annotation_version
    type:
      - 'null'
      - string
    doc: "Version of the motif-to-TF annotation to use. This\n                   \
      \     parameter is used to download the correct motif-to-TF\n              \
      \          data from the cisTarget webservers."
    inputBinding:
      position: 103
      prefix: --annotation_version
  - id: annotations_to_use
    type:
      - 'null'
      - type: array
        items: string
    doc: "Which annotations to use for annotation motifs to TFs.\n               \
      \         Defaults to: Direct_annot Motif_similarity_annot\n               \
      \         Orthology_annot"
      - Direct_annot
      - Motif_similarity_annot
      - Orthology_annot
    inputBinding:
      position: 103
      prefix: --annotations_to_use
  - id: balance_number_of_promoters
    type:
      - 'null'
      - boolean
    doc: "Set this flag to balance the number of promoter\n                      \
      \  regions in fore- and background. When this is set a\n                   \
      \     genome annotation must be provided using the\n                       \
      \ --genome_annotation parameter."
    inputBinding:
      position: 103
      prefix: --balance_number_of_promoters
  - id: dem_db_fname
    type: File
    doc: "Path to the DEM score database\n                        (.regions_vs_motifs.scores.feather)."
    inputBinding:
      position: 103
      prefix: --dem_db_fname
  - id: fraction_overlap_w_dem_database
    type:
      - 'null'
      - float
    doc: Fraction of nucleotides, of regions in the bed file, that should 
      overlap with regions in the dem database in order for them to be included 
      in the analysis.
    inputBinding:
      position: 103
      prefix: --fraction_overlap_w_dem_database
  - id: genome_annotation
    type:
      - 'null'
      - File
    doc: "Path to genome annotation. This parameter is required\n                \
      \        whe balance_number_of_promoters is set. Defaults to\n             \
      \           None."
    inputBinding:
      position: 103
      prefix: --genome_annotation
  - id: log2fc_thr
    type:
      - 'null'
      - float
    doc: "Threshold on the log2 fold change of the motif score\n                 \
      \       of foreground vs background regions for a motif to be\n            \
      \            considered as enriched."
    inputBinding:
      position: 103
      prefix: --log2fc_thr
  - id: max_bg_regions
    type:
      - 'null'
      - int
    doc: "Maximum number of regions to use as background.\n                      \
      \  Defaults to None (i.e. use all regions)"
    inputBinding:
      position: 103
      prefix: --max_bg_regions
  - id: mean_fg_thr
    type:
      - 'null'
      - float
    doc: "Minimul mean signal in the foreground to consider a\n                  \
      \      motif enriched."
    inputBinding:
      position: 103
      prefix: --mean_fg_thr
  - id: motif_hit_thr
    type:
      - 'null'
      - float
    doc: "Minimal CRM score to consider a region enriched for a\n                \
      \        motif. Default: None (It will be automatically\n                  \
      \      calculated based on precision-recall)."
    inputBinding:
      position: 103
      prefix: --motif_hit_thr
  - id: motif_similarity_fdr
    type:
      - 'null'
      - float
    doc: "\" Threshold on motif similarity scores for calling\n                  \
      \      similar motifs. Defaults to: 0.001"
    inputBinding:
      position: 103
      prefix: --motif_similarity_fdr
  - id: name
    type:
      - 'null'
      - string
    doc: "Name of this analysis. This name is appended to the\n                  \
      \      output file name. By default the file name of the bed\n             \
      \           file is used."
    inputBinding:
      position: 103
      prefix: --name
  - id: orthologous_identity_threshold
    type:
      - 'null'
      - float
    doc: "Threshold on the protein-protein orthology score for\n                 \
      \       calling orthologous motifs. Defaults to: 0.0"
    inputBinding:
      position: 103
      prefix: --orthologous_identity_threshold
  - id: output_mode
    type:
      - 'null'
      - string
    doc: "Specifies how the results will be saved to disk. tsv:\n                \
      \        tab-seperated text file containing which motifs are\n             \
      \           enriched. hdf5: a new hdf5 file will be created\n              \
      \          containing the full results. hdf5+: an existing hdf5\n          \
      \              file will be appended with the full motifs enrichment\n     \
      \                   results. Defaults to 'hdf5'"
    inputBinding:
      position: 103
      prefix: --output_mode
  - id: path_to_motif_annotations
    type:
      - 'null'
      - Directory
    doc: "Path to the motif-to-TF annotations. By default this\n                 \
      \       will be downloaded from the cisTarget webservers."
    inputBinding:
      position: 103
      prefix: --path_to_motif_annotations
  - id: promoter_space
    type:
      - 'null'
      - int
    doc: "Number of basepairs up- and downstream of the TSS that\n               \
      \         are considered as being the promoter for that gene."
    inputBinding:
      position: 103
      prefix: --promoter_space
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random seed use for sampling background regions (if\n                  \
      \      max_bg_regions is not None) Defaults to: 555"
    inputBinding:
      position: 103
      prefix: --seed
  - id: species
    type: string
    doc: "Species used for the analysis. This parameter is used\n                \
      \        to download the correct motif-to-TF annotations from\n            \
      \            the cisTarget webservers."
    inputBinding:
      position: 103
      prefix: --species
  - id: write_html
    type:
      - 'null'
      - boolean
    doc: Wether or not to save the results as an html file.
    inputBinding:
      position: 103
      prefix: --write_html
outputs:
  - id: output_folder
    type: Directory
    doc: Path to the folder in which to write results.
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pycistarget:1.1--pyhdfd78af_0
