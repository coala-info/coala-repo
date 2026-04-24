cwlVersion: v1.2
class: CommandLineTool
baseCommand: syngap evi
label: syngap_evi
doc: "Calculate EVI (Expression Variation Index) for gene pairs.\n\nTool homepage:
  https://github.com/yanyew/SynGAP"
inputs:
  - id: format
    type:
      - 'null'
      - string
    doc: The format of output figure
    inputBinding:
      position: 101
      prefix: --format
  - id: genepair
    type: File
    doc: The genepair file (tab-divided) for EVI counting
    inputBinding:
      position: 101
      prefix: --genepair
  - id: sp1exp
    type: File
    doc: The expression file (tab-divided) for species1
    inputBinding:
      position: 101
      prefix: --sp1exp
  - id: sp2exp
    type: File
    doc: The expression file (tab-divided) for species2
    inputBinding:
      position: 101
      prefix: --sp2exp
  - id: weight
    type:
      - 'null'
      - string
    doc: The weight of three indexes in EVI calulating (ML:FC:PCC)
    inputBinding:
      position: 101
      prefix: --weight
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/syngap:1.2.5--py312hdfd78af_0
stdout: syngap_evi.out
