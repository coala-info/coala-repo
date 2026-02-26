cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - igdiscover
  - commonv
label: igdiscover_commonv
doc: "Find common V genes between two different antibody libraries.\n\nTool homepage:
  https://igdiscover.se/"
inputs:
  - id: tables
    type:
      type: array
      items: File
    doc: Tables with parsed and filtered IgBLAST results (give at least two)
    inputBinding:
      position: 1
  - id: minimum_frequency
    type:
      - 'null'
      - int
    doc: Minimum number of datasets in which sequence must occur (default is no.
      of files divided by two)
    inputBinding:
      position: 102
      prefix: --minimum-frequency
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igdiscover:0.15.1--pyhdfd78af_2
stdout: igdiscover_commonv.out
