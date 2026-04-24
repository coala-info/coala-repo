cwlVersion: v1.2
class: CommandLineTool
baseCommand: pycistarget cistarget
label: pycistarget_cistarget
doc: "Run motif enrichment analysis using the cisTarget algorithm.\n\nTool homepage:
  https://github.com/aertslab/pycistarget"
inputs:
  - id: annotation_version
    type:
      - 'null'
      - string
    doc: "Version of the motif-to-TF annotation to use. This\n                   \
      \     parameter is used to download the correct motif-to-TF\n              \
      \          data from the cisTarget webservers. Defaults to:\n              \
      \          v10nr_clust"
    inputBinding:
      position: 101
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
      position: 101
      prefix: --annotations_to_use
  - id: auc_threshold
    type:
      - 'null'
      - float
    doc: "Threshold on the AUC value for calling significant\n                   \
      \     motifs. Defaults to: 0.005"
    inputBinding:
      position: 101
      prefix: --auc_threshold
  - id: bed_fname
    type: File
    doc: "Path to bed file on which to run motif enrichment\n                    \
      \    analysis."
    inputBinding:
      position: 101
      prefix: --bed_fname
  - id: cistarget_db_fname
    type: File
    doc: "Path to the cisTarget rankings database\n                        (.regions_vs_motifs.rankings.feather)."
    inputBinding:
      position: 101
      prefix: --cistarget_db_fname
  - id: fr_overlap_w_ctx_db
    type:
      - 'null'
      - float
    doc: "Fraction of nucleotides, of regions in the bed file,\n                 \
      \       that should overlap with regions in the cistarget\n                \
      \        database in order for them to be included in the\n                \
      \        analysis. Defaults to: 0.4"
    inputBinding:
      position: 101
      prefix: --fr_overlap_w_ctx_db
  - id: motif_similarity_fdr
    type:
      - 'null'
      - float
    doc: "\" Threshold on motif similarity scores for calling\n                  \
      \      similar motifs. Defaults to: 0.001"
    inputBinding:
      position: 101
      prefix: --motif_similarity_fdr
  - id: name
    type:
      - 'null'
      - string
    doc: "Name of this analysis. This name is appended to the\n                  \
      \      output file name. By default the file name of the bed\n             \
      \           file is used."
    inputBinding:
      position: 101
      prefix: --name
  - id: nes_threshold
    type:
      - 'null'
      - float
    doc: "Threshold on the NES value for calling significant\n                   \
      \     motifs. NES - Normalised Enrichment Score - is defined\n             \
      \           as (AUC - Avg(AUC)) / sd(AUC). Defaults to: 3.0"
    inputBinding:
      position: 101
      prefix: --nes_threshold
  - id: orthologous_identity_threshold
    type:
      - 'null'
      - float
    doc: "Threshold on the protein-protein orthology score for\n                 \
      \       calling orthologous motifs. Defaults to: 0.0"
    inputBinding:
      position: 101
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
      position: 101
      prefix: --output_mode
  - id: path_to_motif_annotations
    type:
      - 'null'
      - Directory
    doc: "Path to the motif-to-TF annotations. By default this\n                 \
      \       will be downloaded from the cisTarget webservers."
    inputBinding:
      position: 101
      prefix: --path_to_motif_annotations
  - id: rank_threshold
    type:
      - 'null'
      - float
    doc: "The total number of ranked regions to take into\n                      \
      \  account when creating a recovery curves. Defaults to:\n                 \
      \       0.05"
    inputBinding:
      position: 101
      prefix: --rank_threshold
  - id: species
    type: string
    doc: "Species used for the analysis. This parameter is used\n                \
      \        to download the correct motif-to-TF annotations from\n            \
      \            the cisTarget webservers."
    inputBinding:
      position: 101
      prefix: --species
  - id: write_html
    type:
      - 'null'
      - boolean
    doc: Wether or not to save the results as an html file.
    inputBinding:
      position: 101
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
