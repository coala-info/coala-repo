cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scenicplus
  - grn_inference
  - motif_enrichment_dem
label: scenicplus_motif_enrichment_dem
doc: "Run motif enrichment on a set of regions using the differential enrichment of motifs (DEM) algorithm.\n\nTool homepage: https://github.com/aertslab/scenicplus"
inputs:
  - id: region_set_folder
    type: Directory
    doc: "Path to the folder containing folders of bed files."
    inputBinding:
      position: 101
      prefix: --region_set_folder
  - id: dem_db_fname
    type: File
    doc: "Path to the DEM score database (.regions_vs_motifs.scores.feather)."
    inputBinding:
      position: 101
      prefix: --dem_db_fname
  - id: output_fname_dem_result_path
    type: string
    doc: "Path to store dem result (.hdf5)."
    inputBinding:
      position: 102
      prefix: --output_fname_dem_result
  - id: temp_dir
    type: string
    doc: "Path to temp dir."
    inputBinding:
      position: 101
      prefix: --temp_dir
  - id: species
    type: string
    doc: "Species used for the analysis. This parameter is used to download the correct motif-to-TF annotations from the cisTarget webservers."
    inputBinding:
      position: 101
      prefix: --species
  - id: fraction_overlap_w_dem_database
    type:
      - 'null'
      - float
    doc: "Fraction of nucleotides, of regions in the bed file, that should overlap with regions in the dem database in order for them to be included in the analysis. Defaults to: 0.4"
    inputBinding:
      position: 101
      prefix: --fraction_overlap_w_dem_database
  - id: max_bg_regions
    type:
      - 'null'
      - int
    doc: "Maximum number of regions to use as background. Defaults to None (i.e. use all regions)"
    inputBinding:
      position: 101
      prefix: --max_bg_regions
  - id: genome_annotation
    type:
      - 'null'
      - File
    doc: "Path to genome annotation. This parameter is required whe balance_number_of_promoters is set. Defaults to None."
    inputBinding:
      position: 101
      prefix: --genome_annotation
  - id: balance_number_of_promoters
    type:
      - 'null'
      - boolean
    doc: "Set this flag to balance the number of promoter regions in fore- and background. When this is set a genome annotation must be provided using the --genome_annotation parameter."
    inputBinding:
      position: 101
      prefix: --balance_number_of_promoters
  - id: promoter_space
    type:
      - 'null'
      - int
    doc: "Number of basepairs up- and downstream of the TSS that are considered as being the promoter for that gene. Defaults to: 1000"
    inputBinding:
      position: 101
      prefix: --promoter_space
  - id: adjpval_thr
    type:
      - 'null'
      - float
    doc: "Threshold on the Benjamini-Hochberg adjusted p-value from the Wilcoxon test performed on the motif score of foreground vs background regions for a motif to be considered as enriched. Defaults to: 0.05"
    inputBinding:
      position: 101
      prefix: --adjpval_thr
  - id: log2fc_thr
    type:
      - 'null'
      - float
    doc: "Threshold on the log2 fold change of the motif score of foreground vs background regions for a motif to be considered as enriched. Defaults to: 1.0"
    inputBinding:
      position: 101
      prefix: --log2fc_thr
  - id: mean_fg_thr
    type:
      - 'null'
      - float
    doc: "Minimul mean signal in the foreground to consider a motif enriched. Defaults to: 0.0"
    inputBinding:
      position: 101
      prefix: --mean_fg_thr
  - id: motif_hit_thr
    type:
      - 'null'
      - float
    doc: "Minimal CRM score to consider a region enriched for a motif. Default: None (It will be automatically calculated based on precision-recall)."
    inputBinding:
      position: 101
      prefix: --motif_hit_thr
  - id: path_to_motif_annotations
    type:
      - 'null'
      - File
    doc: "Path to the motif-to-TF annotations. By default this will be downloaded from the cisTarget webservers."
    inputBinding:
      position: 101
      prefix: --path_to_motif_annotations
  - id: annotation_version
    type:
      - 'null'
      - string
    doc: "Version of the motif-to-TF annotation to use. This parameter is used to download the correct motif-to-TF data from the cisTarget webservers. Defaults to: v10nr_clust"
    inputBinding:
      position: 101
      prefix: --annotation_version
  - id: motif_similarity_fdr
    type:
      - 'null'
      - float
    doc: "\" Threshold on motif similarity scores for calling similar motifs. Defaults to: 0.001"
    inputBinding:
      position: 101
      prefix: --motif_similarity_fdr
  - id: orthologous_identity_threshold
    type:
      - 'null'
      - float
    doc: "Threshold on the protein-protein orthology score for calling orthologous motifs. Defaults to: 0.0"
    inputBinding:
      position: 101
      prefix: --orthologous_identity_threshold
  - id: annotations_to_use
    type:
      - 'null'
      - type: array
        items: string
    doc: "Which annotations to use for annotation motifs to TFs. Defaults to: Direct_annot Motif_similarity_annot Orthology_annot"
    inputBinding:
      position: 101
      prefix: --annotations_to_use
  - id: write_html
    type:
      - 'null'
      - boolean
    doc: "Wether or not to save the results as an html file."
    inputBinding:
      position: 101
      prefix: --write_html
  - id: output_fname_dem_html_path
    type:
      - 'null'
      - string
    doc: "Path to store dem result html (.html), only if --write_html."
    inputBinding:
      position: 102
      prefix: --output_fname_dem_html
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random seed use for sampling background regions (if max_bg_regions is not None) Defaults to: 555"
    inputBinding:
      position: 101
      prefix: --seed
  - id: n_cpu
    type:
      - 'null'
      - int
    doc: "Number of cores to use. Default is 1."
    inputBinding:
      position: 101
      prefix: --n_cpu
outputs:
  - id: output_fname_dem_result
    type:
      - 'null'
      - File
    doc: "Path to store dem result (.hdf5)."
    outputBinding:
      glob: "$(inputs.output_fname_dem_result_path)"
  - id: output_fname_dem_html
    type:
      - 'null'
      - File
    doc: "Path to store dem result html (.html), only if --write_html."
    outputBinding:
      glob: "$(inputs.output_fname_dem_html_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scenicplus:1.0a2--pyhdfd78af_0
