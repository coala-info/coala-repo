cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - methbat
  - deconvolve
label: methbat_deconvolve
doc: "Perform cell-type deconvolution based on an atlas\n\nTool homepage: https://github.com/PacificBiosciences/MethBat"
inputs:
  - id: atlas_regions
    type: File
    doc: Input atlas regions (CSV/TSV)
    inputBinding:
      position: 101
      prefix: --atlas-regions
  - id: input_prefix
    type: string
    doc: Input prefix from pb-CpG-tools
    inputBinding:
      position: 101
      prefix: --input-prefix
  - id: min_active
    type:
      - 'null'
      - float
    doc: Minimum active proportion threshold for cell type filtering
    default: 0.05
    inputBinding:
      position: 101
      prefix: --min-active
outputs:
  - id: output_estimate
    type: File
    doc: Output summary file from deconvolution estimates (JSON)
    outputBinding:
      glob: $(inputs.output_estimate)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methbat:0.17.0--h9ee0642_0
