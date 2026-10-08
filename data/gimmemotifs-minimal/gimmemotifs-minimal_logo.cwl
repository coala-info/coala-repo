cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gimme
  - logo
label: gimmemotifs-minimal_logo
doc: "Create sequence logo(s)\n\nTool homepage: https://github.com/vanheeringen-lab/gimmemotifs"
inputs:
  - id: pfmfile
    type:
      - 'null'
      - File
    doc: "PFM file with motifs"
    inputBinding:
      position: 1
      prefix: --pfmfile
  - id: ids
    type:
      - 'null'
      - string
    doc: "Comma-separated list of motif ids (default is all ids)"
    inputBinding:
      position: 1
      prefix: --ids
  - id: kind
    type:
      - 'null'
      - string
    doc: "Type of motif (information, frequency, energy or ensembl)"
    inputBinding:
      position: 1
      prefix: --kind
  - id: notitle
    type:
      - 'null'
      - boolean
    doc: "Don't include motif ID as title"
    inputBinding:
      position: 1
      prefix: --notitle
outputs:
  - id: logos
    type: File[]
    doc: "One PNG logo per motif"
    outputBinding:
      glob: '*.png'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gimmemotifs-minimal:0.18.1--py39hbcbf7aa_0
