cwlVersion: v1.2
class: CommandLineTool
baseCommand: gbmunge
label: gbmunge
doc: "Extract from a GenBank flat file.\n\nTool homepage: https://github.com/sdwfrost/gbmunge"
inputs:
  - id: genbank_file
    type: File
    doc: Genbank_file
    inputBinding:
      position: 101
      prefix: -i
  - id: skip_header
    type:
      - 'null'
      - boolean
    doc: Skip header
    inputBinding:
      position: 101
      prefix: -s
  - id: transpose
    type:
      - 'null'
      - boolean
    doc: Transpose the output
    inputBinding:
      position: 101
      prefix: -t
  - id: metadata_output_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `metadata_output_path`
    inputBinding:
      position: 102
      prefix: --metadata-output
  - id: sequence_output_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `sequence_output_path`
    inputBinding:
      position: 103
      prefix: --sequence-output
outputs:
  - id: sequence_output
    type: File
    doc: sequence_output
    outputBinding:
      glob: $(inputs.sequence_output_path)
  - id: metadata_output
    type: File
    doc: metadata_output
    outputBinding:
      glob: $(inputs.metadata_output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gbmunge:2018.07.06--h7b50bb2_7
