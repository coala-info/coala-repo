cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - qimba
  - show-samples
label: qimba_show-samples
doc: "Display sample information from a mapping file.\n\nTool homepage: https://github.com/quadram-institute-bioscience/qimba"
inputs:
  - id: mapping_file
    type: File
    doc: Mapping file
    inputBinding:
      position: 1
  - id: attr
    type:
      - 'null'
      - string
    doc: Show specific attribute for all samples
    inputBinding:
      position: 102
      prefix: --attr
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qimba:0.4.0--pyhdfd78af_0
stdout: qimba_show-samples.out
