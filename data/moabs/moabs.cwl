cwlVersion: v1.2
class: CommandLineTool
baseCommand: moabs
label: moabs
doc: "moabs\n\nTool homepage: https://github.com/sunnyisgalaxy/moabs"
inputs:
  - id: configuration_file
    type:
      - 'null'
      - File
    doc: configuration file.
    inputBinding:
      position: 101
      prefix: --cf
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: input files. Inputs are FASTQ files.
    inputBinding:
      position: 101
      prefix: -i
  - id: overwrite_definitions
    type:
      - 'null'
      - string
    doc: overwrite definitions in configuration file. --def key=value
    inputBinding:
      position: 101
      prefix: --def
  - id: verbose_output
    type:
      - 'null'
      - boolean
    doc: verbose output
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moabs:1.3.9.6--pl526r40h3d033a0_0
stdout: moabs.out
