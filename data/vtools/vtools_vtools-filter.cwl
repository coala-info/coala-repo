cwlVersion: v1.2
class: CommandLineTool
baseCommand: vtools-filter
label: vtools_vtools-filter
doc: "Filter VCF files based on provided parameters.\n\nTool homepage: https://github.com/LUMC/vtools"
inputs:
  - id: immediate_return
    type:
      - 'null'
      - boolean
    doc: Immediately write filters to file upon hitting one filter criterium.
    default: true
    inputBinding:
      position: 101
      prefix: --immediate-return
  - id: index_sample
    type: string
    doc: Name of index sample
    inputBinding:
      position: 101
      prefix: --index-sample
  - id: input_file
    type: File
    doc: Path to input VCF file
    inputBinding:
      position: 101
      prefix: --input
  - id: no_immediate_return
    type:
      - 'null'
      - boolean
    doc: Do not immediately write filters to file upon hitting one filter 
      criterium.
    default: false
    inputBinding:
      position: 101
      prefix: --no-immediate-return
  - id: params_file
    type: File
    doc: Path to filter params json
    inputBinding:
      position: 101
      prefix: --params-file
  - id: trash_file
    type: File
    doc: Path to trash VCF file
    inputBinding:
      position: 101
      prefix: --trash
outputs:
  - id: output_file
    type: File
    doc: Path to output (filtered) VCF file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vtools:1.1.0--py311h93dcfea_7
