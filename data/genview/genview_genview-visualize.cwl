cwlVersion: v1.2
class: CommandLineTool
baseCommand: genview-visualize
label: genview_genview-visualize
doc: "Extract, visualize and annotate genes and genetic environments from genview
  database\n\nTool homepage: https://github.com/EbmeyerSt/GEnView.git"
inputs:
  - id: compressed
    type:
      - 'null'
      - boolean
    doc: Compress number of displayed sequences, helpful with large number of 
      identical sequences
    inputBinding:
      position: 101
      prefix: --compressed
  - id: custom_colors
    type:
      - 'null'
      - File
    doc: path to file containing RGB color codes for gene color customization
    inputBinding:
      position: 101
      prefix: --custom_colors
  - id: db
    type: string
    doc: genview database created by genview-create-db
    inputBinding:
      position: 101
      prefix: -db
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force new alignment and phylogeny
    inputBinding:
      position: 101
      prefix: --force
  - id: gene
    type: string
    doc: name of gene/orf to extract and visualize
    inputBinding:
      position: 101
      prefix: -gene
  - id: id
    type: string
    doc: percent identity threshold for genes to extract
    inputBinding:
      position: 101
      prefix: -id
  - id: log
    type:
      - 'null'
      - boolean
    doc: Write log file
    inputBinding:
      position: 101
      prefix: --log
  - id: nodes
    type:
      - 'null'
      - string
    doc: should nodes be connected to genome with solid line (solid), connected 
      by dashed line (dash) or no connection (none)
    inputBinding:
      position: 101
      prefix: -nodes
  - id: taxa
    type:
      - 'null'
      - type: array
        items: string
    doc: "list of genera and/or species to extract\n                        By default
      all taxa are extracted"
    inputBinding:
      position: 101
      prefix: -taxa
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genview:0.2--pyhdfd78af_0
stdout: genview_genview-visualize.out
