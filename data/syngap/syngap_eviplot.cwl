cwlVersion: v1.2
class: CommandLineTool
baseCommand: syngap_eviplot
label: syngap_eviplot
doc: "Generate an EVI plot from a tab-divided EVI file.\n\nTool homepage: https://github.com/yanyew/SynGAP"
inputs:
  - id: evi_file
    type: File
    doc: The EVI file (tab-divided) for ploting
    inputBinding:
      position: 101
      prefix: --EVI
  - id: figsize
    type:
      - 'null'
      - string
    doc: The size of output graph (LengthxWidth)
    inputBinding:
      position: 101
      prefix: --figsize
  - id: fontsize
    type:
      - 'null'
      - int
    doc: The font size of output graph
    inputBinding:
      position: 101
      prefix: --fontsize
  - id: highlight_color
    type:
      - 'null'
      - string
    doc: The color for highlight label
    inputBinding:
      position: 101
      prefix: --highlightcolor
  - id: highlightid_file
    type:
      - 'null'
      - File
    doc: The id list file (tab-divided) for highlightid
    inputBinding:
      position: 101
      prefix: --highlightid
outputs:
  - id: outgraph
    type: File
    doc: The output graph file (output format determined by the file suffix)
    outputBinding:
      glob: $(inputs.outgraph)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/syngap:1.2.5--py312hdfd78af_0
