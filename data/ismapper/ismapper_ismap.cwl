cwlVersion: v1.2
class: CommandLineTool
baseCommand: ismap
label: ismapper_ismap
doc: "Basic ISMapper options:\n\nTool homepage: https://github.com/jhawkey/IS_mapper/"
inputs:
  - id: reads
    type:
      type: array
      items: File
    doc: Paired end reads for analysing (can be gzipped)
    inputBinding:
      position: 1
  - id: queries
    type:
      type: array
      items: File
    doc: 'Multifasta file for query gene(s) (eg: insertion sequence) that will be
      mapped to.'
    inputBinding:
      position: 2
  - id: reference
    type:
      type: array
      items: File
    doc: Reference genome for typing against in genbank format
    inputBinding:
      position: 3
  - id: help_all
    type:
      - 'null'
      - string
    doc: Display extended help
    inputBinding:
      position: 104
      prefix: --help_all
  - id: log
    type:
      - 'null'
      - string
    doc: Prefix for log file. If not supplied, prefix will be current date and 
      time.
    inputBinding:
      position: 104
      prefix: --log
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Location for all output files (default is current directory).
    inputBinding:
      position: 104
      prefix: --output_dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ismapper:2.0.2--pyhdfd78af_1
stdout: ismapper_ismap.out
