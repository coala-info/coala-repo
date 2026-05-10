cwlVersion: v1.2
class: CommandLineTool
baseCommand: gunc merge_checkm
label: gunc_merge_checkm
doc: "Merge GUNC and CheckM results\n\nTool homepage: https://github.com/grp-bork/gunc"
inputs:
  - id: checkm_file
    type: File
    doc: Path to the CheckM file
    inputBinding:
      position: 101
      prefix: --checkm_file
  - id: gunc_file
    type: File
    doc: Path to the GUNC file
    inputBinding:
      position: 101
      prefix: --gunc_file
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 101
      prefix: --verbose
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 102
      prefix: --output-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Path to the output merged file
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gunc:1.0.6--pyhdfd78af_1
