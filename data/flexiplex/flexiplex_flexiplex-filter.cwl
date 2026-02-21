cwlVersion: v1.2
class: CommandLineTool
baseCommand: flexiplex-filter
label: flexiplex_flexiplex-filter
doc: "A tool to filter flexiplex results, typically processing count data from a file
  or stdin.\n\nTool homepage: https://github.com/DavidsonGroup/flexiplex/"
inputs:
  - id: filename
    type:
      - 'null'
      - File
    doc: Input file containing counts to be filtered. If not provided, reads from
      stdin.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flexiplex:1.02.5--py313h9948957_1
stdout: flexiplex_flexiplex-filter.out
