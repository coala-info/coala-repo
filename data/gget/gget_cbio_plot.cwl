cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gget
  - cbio
  - plot
label: gget_cbio_plot
doc: 'Plot a heatmap of cancer genomics data.


  Tool homepage: https://github.com/pachterlab/gget'
inputs:
  - id: genes
    type:
      type: array
      items: string
    doc: Space-separated list of gene names or Ensembl IDs, e.g. `NOTCH3 ENSG00000108375`
    inputBinding:
      position: 101
      prefix: --genes
  - id: study_ids
    type:
      type: array
      items: string
    doc: Space-separated list of cBioPortal study IDs, e.g. `msk_impact_2017 egc_msk_2023`
    inputBinding:
      position: 101
      prefix: --study_ids
  - id: data_dir
    type: string
    default: gget_cbio_cache
    doc: 'Directory to store downloaded data (default: ./gget_cbio_cache)'
    inputBinding:
      position: 102
      prefix: --data_dir
  - id: dpi
    type:
      - 'null'
      - int
    doc: 'DPI of the generated figures (default: 100)'
    inputBinding:
      position: 102
      prefix: --dpi
  - id: filename
    type:
      - 'null'
      - string
    doc: 'Filename for the generated figure, relative to `figure_dir` (default: auto-generated)'
    inputBinding:
      position: 102
      prefix: --filename
  - id: filter
    type:
      - 'null'
      - string
    doc: Filter the heatmap by a specific value in a specific column, e.g. `tissue:intestine`
    inputBinding:
      position: 102
      prefix: --filter
  - id: figure_dir
    type: string
    default: gget_cbio_figures
    doc: 'Directory to store generated figures (default: ./gget_cbio_figures)'
    inputBinding:
      position: 102
      prefix: --figure_dir
  - id: no_confirm
    type:
      - 'null'
      - boolean
    default: true
    doc: Skip confirmation before downloading data.
    inputBinding:
      position: 102
      prefix: --no_confirm
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Does not print progress information.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: show
    type:
      - 'null'
      - boolean
    doc: Show the plot in a window
    inputBinding:
      position: 102
      prefix: --show
  - id: stratification
    type:
      - 'null'
      - string
    doc: 'Column to stratify the heatmap by: tissue, cancer_type, cancer_type_detailed,
      study_id or sample. (default: tissue)'
    inputBinding:
      position: 102
      prefix: --stratification
  - id: title
    type:
      - 'null'
      - string
    doc: 'Title for the generated figure (default: auto-generated)'
    inputBinding:
      position: 102
      prefix: --title
  - id: variation_type
    type:
      - 'null'
      - string
    doc: 'Type of variation to plot: mutation_occurrences, cna_nonbinary, sv_occurrences,
      cna_occurrences or Consequence. (default: mutation_occurrences)'
    inputBinding:
      position: 102
      prefix: --variation_type
outputs:
  - id: figures
    type: Directory
    doc: Folder with the generated heatmap figure.
    outputBinding:
      glob: $(inputs.figure_dir)
  - id: data
    type:
      - 'null'
      - Directory
    doc: Folder with the downloaded cBioPortal data.
    outputBinding:
      glob: $(inputs.data_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
