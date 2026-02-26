cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqmagick extract-ids
label: seqmagick_extract-ids
doc: "Extract the sequence IDs from a file\n\nTool homepage: http://github.com/fhcrc/seqmagick"
inputs:
  - id: sequence_file
    type: File
    doc: Sequence file
    inputBinding:
      position: 1
  - id: include_description
    type:
      - 'null'
      - boolean
    doc: Include the sequence description in output
    default: false
    inputBinding:
      position: 102
      prefix: --include-description
  - id: input_format
    type:
      - 'null'
      - string
    doc: Input format for sequence file
    inputBinding:
      position: 102
      prefix: --input-format
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Destination file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqmagick:0.8.6--pyhdfd78af_0
