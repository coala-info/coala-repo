cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaWRAP
label: metawrap-refinement_metawrap
doc: "MetaWRAP: A flexible pipeline for genome-resolved metagenomic data analysis.
  Please select a proper module.\n\nTool homepage: https://github.com/bxlab/metaWRAP"
inputs:
  - id: module
    type: string
    doc: 'The metaWRAP module to run. Options include: read_qc, assembly, kraken,
      blobology, binning, bin_refinement, reassemble_bins, quant_bins, classify_bins,
      annotate_bins'
    inputBinding:
      position: 1
  - id: show_config
    type:
      - 'null'
      - boolean
    doc: show where the metawrap configuration files are stored
    inputBinding:
      position: 102
      prefix: --show-config
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metawrap:1.2--0
stdout: metawrap-refinement_metawrap.out
