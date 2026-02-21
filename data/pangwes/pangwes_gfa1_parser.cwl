cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/gfa1_parser
label: pangwes_gfa1_parser
doc: "Parser for GFA1 files\n\nTool homepage: https://github.com/jurikuronen/PANGWES"
inputs:
  - id: input_gfa1
    type:
      - 'null'
      - File
    doc: Input GFA1 file
    inputBinding:
      position: 1
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangwes:0.3.0_alpha--h9948957_1
