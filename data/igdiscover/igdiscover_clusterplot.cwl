cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - igdiscover
  - clusterplot
label: igdiscover_clusterplot
doc: "Plot a clustermap of all sequences assigned to a gene\n\nTool homepage: https://igdiscover.se/"
inputs:
  - id: table
    type: File
    doc: Table with parsed and filtered IgBLAST results
    inputBinding:
      position: 1
  - id: directory
    type: Directory
    doc: Save clustermaps as PNG into this directory
    inputBinding:
      position: 2
  - id: dpi
    type:
      - 'null'
      - int
    doc: Resolution of output file.
    default: 200
    inputBinding:
      position: 103
      prefix: --dpi
  - id: gene
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Plot GENE. Can be given multiple times. Default: Plot all genes.'
    inputBinding:
      position: 103
      prefix: --gene
  - id: ignore_j
    type:
      - 'null'
      - boolean
    doc: Include also rows without J assignment or J%SHM>0.
    inputBinding:
      position: 103
      prefix: --ignore-J
  - id: minimum_group_size
    type:
      - 'null'
      - int
    doc: Do not plot if there are less than N sequences for a gene.
    default: 200
    inputBinding:
      position: 103
      prefix: --minimum-group-size
  - id: no_title
    type:
      - 'null'
      - boolean
    doc: Do not add a title to the plot
    inputBinding:
      position: 103
      prefix: --no-title
  - id: size
    type:
      - 'null'
      - int
    doc: Show at most N sequences (with a matrix of size N x N).
    default: 300
    inputBinding:
      position: 103
      prefix: --size
  - id: type
    type:
      - 'null'
      - string
    doc: Gene type.
    default: V
    inputBinding:
      position: 103
      prefix: --type
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igdiscover:0.15.1--pyhdfd78af_2
stdout: igdiscover_clusterplot.out
