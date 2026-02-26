cwlVersion: v1.2
class: CommandLineTool
baseCommand: seabreeze
label: seabreeze-genomics_seabreeze
doc: "seabreeze is a tool for comprehensively analyzing genetic variation among\n\
  bacterial genomes caused by structural mutations.\n\nTool homepage: https://github.com/barricklab/seabreeze"
inputs:
  - id: batch
    type:
      - 'null'
      - boolean
    doc: Run seabreeze in batch mode to process multiple samples at once
    inputBinding:
      position: 101
      prefix: --batch
  - id: run
    type:
      - 'null'
      - boolean
    doc: Run seabreeze for a single sample pair
    inputBinding:
      position: 101
      prefix: --run
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seabreeze-genomics:1.5.0--pyhdfd78af_0
stdout: seabreeze-genomics_seabreeze.out
