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
    inputBinding:
      position: 101
      prefix: --min-active
  - id: output_estimate_path
    type: string
    doc: Output summary file from deconvolution estimates (JSON)
    inputBinding:
      position: 102
      prefix: --output-estimate
  - id: pileup_files
    type:
      type: array
      items: File
    doc: pb-CpG-tools output files for the input prefix (<prefix>.combined.bed.gz, optional <prefix>.hap1.bed.gz and <prefix>.hap2.bed.gz with their .tbi). Staged in the working directory so the prefix resolves.
outputs:
  - id: output_estimate
    type: File
    doc: Output summary file from deconvolution estimates (JSON)
    outputBinding:
      glob: $(inputs.output_estimate_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.pileup_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methbat:0.17.0--h9ee0642_0
