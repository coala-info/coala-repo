cwlVersion: v1.2
class: CommandLineTool
baseCommand: artic rampart
label: artic_rampart
doc: "RAMPART is a tool for the analysis of sequencing data from pathogen surveillance.\n\
  \nTool homepage: https://github.com/artic-network/fieldbioinformatics"
inputs:
  - id: protocol_directory
    type:
      - 'null'
      - Directory
    doc: The RAMPART protocols directory.
    inputBinding:
      position: 101
      prefix: --protocol-directory
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not output warnings to stderr
    inputBinding:
      position: 101
      prefix: --quiet
  - id: run_directory
    type:
      - 'null'
      - Directory
    doc: The run directory
    inputBinding:
      position: 101
      prefix: --run-directory
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/artic:1.8.5--pyhdfd78af_0
stdout: artic_rampart.out
