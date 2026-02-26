cwlVersion: v1.2
class: CommandLineTool
baseCommand: circos
label: circos
doc: "Circos could not find the configuration file []. To run Circos, you need to
  specify this file using the -conf flag. The configuration file contains all the
  parameters that define the image, including input files, image size, formatting,
  etc.\n\nTool homepage: http://circos.ca"
inputs:
  - id: conf
    type:
      - 'null'
      - File
    doc: Specify the configuration file
    inputBinding:
      position: 101
      prefix: -conf
  - id: debug_flag
    type:
      - 'null'
      - string
    doc: Enable specific debugging flags (e.g., 'io')
    inputBinding:
      position: 101
      prefix: -debug_flag
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/circos:0.69.9--hdfd78af_0
stdout: circos.out
