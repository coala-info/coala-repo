cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - octopusv
  - svcf2bedpe
label: octopusv_svcf2bedpe
doc: "Convert SVCF file to BEDPE format.\n\nTool homepage: https://github.com/ylab-hi/octopusV"
inputs:
  - id: input_file
    type: File
    doc: Input SVCF file to convert.
    inputBinding:
      position: 101
      prefix: --input-file
  - id: minimal
    type:
      - 'null'
      - boolean
    doc: Output minimal BEDPE format (only coordinate columns)
    inputBinding:
      position: 101
      prefix: --minimal
outputs:
  - id: output_file
    type: File
    doc: Output BEDPE file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/octopusv:0.3.0--pyhdfd78af_0
