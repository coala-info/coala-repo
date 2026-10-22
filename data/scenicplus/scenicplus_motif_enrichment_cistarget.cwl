cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scenicplus
  - grn_inference
  - motif_enrichment_cistarget
label: scenicplus_motif_enrichment_cistarget
doc: "Run motif enrichment on a set of regions using the cistarget algorithm.\n\nTool homepage: https://github.com/aertslab/scenicplus"
inputs:
  - id: region_set_folder
    type: Directory
    doc: "Path to the folder containing folders of bed files."
    inputBinding:
      position: 101
      prefix: --region_set_folder
  - id: cistarget_db_fname
    type: File
    doc: "Path to the cisTarget rankings database (.regions_vs_motifs.rankings.feather)."
    inputBinding:
      position: 101
      prefix: --cistarget_db_fname
  - id: output_fname_cistarget_result_path
    type: string
    doc: "Path to store cistarget result (.hdf5)."
    inputBinding:
      position: 102
      prefix: --output_fname_cistarget_result
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
  - id: fr_overlap_w_ctx_db
    type:
      - 'null'
      - float
    doc: "Fraction of nucleotides, of regions in the bed file, that should overlap with regions in the cistarget database in order for them to be included in the analysis. Defaults to: 0.4"
    inputBinding:
      position: 101
      prefix: --fr_overlap_w_ctx_db
  - id: auc_threshold
    type:
      - 'null'
      - float
    doc: "Threshold on the AUC value for calling significant motifs. Defaults to: 0.005"
    inputBinding:
      position: 101
      prefix: --auc_threshold
  - id: nes_threshold
    type:
      - 'null'
      - float
    doc: "Threshold on the NES value for calling significant motifs. NES - Normalised Enrichment Score - is defined as (AUC - Avg(AUC)) / sd(AUC). Defaults to: 3.0"
    inputBinding:
      position: 101
      prefix: --nes_threshold
  - id: rank_threshold
    type:
      - 'null'
      - int
    doc: "The total number of ranked regions to take into account when creating a recovery curves. Defaults to: 0.05"
    inputBinding:
      position: 101
      prefix: --rank_threshold
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
  - id: output_fname_cistarget_html_path
    type:
      - 'null'
      - string
    doc: "Path to store cistarget result html (.html), only if --write_html."
    inputBinding:
      position: 102
      prefix: --output_fname_cistarget_html
  - id: n_cpu
    type:
      - 'null'
      - int
    doc: "Number of cores to use. Default is 1."
    inputBinding:
      position: 101
      prefix: --n_cpu
outputs:
  - id: output_fname_cistarget_result
    type:
      - 'null'
      - File
    doc: "Path to store cistarget result (.hdf5)."
    outputBinding:
      glob: "$(inputs.output_fname_cistarget_result_path)"
  - id: output_fname_cistarget_html
    type:
      - 'null'
      - File
    doc: "Path to store cistarget result html (.html), only if --write_html."
    outputBinding:
      glob: "$(inputs.output_fname_cistarget_html_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scenicplus:1.0a2--pyhdfd78af_0
