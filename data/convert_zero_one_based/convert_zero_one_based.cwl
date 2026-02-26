cwlVersion: v1.2
class: CommandLineTool
baseCommand: convert_zero_one_based
label: convert_zero_one_based
doc: "Converts between zero-based and one-based indexing in BED files.\n\nTool homepage:
  https://github.com/griffithlab/convert_zero_one_based.git"
inputs:
  - id: input_file
    type: File
    doc: Input BED file.
    inputBinding:
      position: 1
  - id: from_one_based
    type:
      - 'null'
      - boolean
    doc: Convert from one-based to zero-based indexing.
    inputBinding:
      position: 102
      prefix: --from-one-based
  - id: from_zero_based
    type:
      - 'null'
      - boolean
    doc: Convert from zero-based to one-based indexing.
    inputBinding:
      position: 102
      prefix: --from-zero-based
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output BED file. If not specified, output to stdout.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/convert_zero_one_based:0.0.1--py_0
