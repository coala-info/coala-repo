cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-gifti-convert'
label: connectome-workbench_wb_command_gifti-convert
doc: "Convert a gifti file to a different encoding: ASCII, BASE64_BINARY, GZIP_BASE64_BINARY or EXTERNAL_FILE_BINARY.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: gifti_encoding
    type: string
    doc: 'what the output encoding should be: ASCII, BASE64_BINARY, GZIP_BASE64_BINARY or EXTERNAL_FILE_BINARY'
    inputBinding:
      position: 1
  - id: input_gifti_file
    type: File
    doc: the input gifti file
    inputBinding:
      position: 2
  - id: output_gifti_file
    type: string
    doc: output - the output gifti file
    inputBinding:
      position: 3
outputs:
  - id: converted_gifti
    type: File
    doc: the output gifti file
    outputBinding:
      glob: $(inputs.output_gifti_file)
  - id: external_data
    type:
      - 'null'
      - File
    doc: the external binary data file written with EXTERNAL_FILE_BINARY
    outputBinding:
      glob: $(inputs.output_gifti_file).data
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
