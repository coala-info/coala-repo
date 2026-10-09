cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - igdiscover
  - clusterplot
label: igdiscover_clusterplot
doc: "Plot a clustermap of all sequences assigned to a gene. PNG files are saved into the output directory.\n\nTool homepage: https://igdiscover.se/"
inputs:
  - id: table
    type: File
    doc: "Table with parsed and filtered IgBLAST results"
    inputBinding:
      position: 1
  - id: directory
    type: string
    doc: "Save clustermaps as PNG into this directory"
    inputBinding:
      position: 2
  - id: minimum_group_size
    type: ['null', int]
    doc: "Do not plot if there are less than N sequences for a gene. Default: 200"
    inputBinding:
      position: 3
      prefix: --minimum-group-size
  - id: gene
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --gene
    doc: "Plot GENE. Can be given multiple times. Default: plot all genes."
    inputBinding:
      position: 3
  - id: type
    type: ['null', string]
    doc: "Gene type: V, D or J. Default: V"
    inputBinding:
      position: 3
      prefix: --type
  - id: size
    type: ['null', int]
    doc: "Show at most N sequences (with a matrix of size N x N). Default: 300"
    inputBinding:
      position: 3
      prefix: --size
  - id: ignore_j
    type: ['null', boolean]
    doc: "Include also rows without J assignment or J%SHM>0."
    inputBinding:
      position: 3
      prefix: --ignore-J
  - id: dpi
    type: ['null', int]
    doc: "Resolution of output file. Default: 200"
    inputBinding:
      position: 3
      prefix: --dpi
  - id: no_title
    type: ['null', boolean]
    doc: "Do not add a title to the plot"
    inputBinding:
      position: 3
      prefix: --no-title
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
  - id: plots
    type: Directory
    doc: "Directory with the clustermap PNG files"
    outputBinding:
      glob: $(inputs.directory)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igdiscover:0.15.1--pyhdfd78af_2
stdout: igdiscover_clusterplot.out
