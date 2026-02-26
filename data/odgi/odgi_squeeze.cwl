cwlVersion: v1.2
class: CommandLineTool
baseCommand: odgi squeeze
label: odgi_squeeze
doc: "Squeezes multiple graphs in ODGI format into the same file in ODGI format.\n\
  \nTool homepage: https://github.com/vgteam/odgi"
inputs:
  - id: input_graphs
    type: File
    doc: Input file containing the list of graphs to squeeze into the same file.
      The file must contain one graph per line. It also accepts GFAv1, but the 
      on-the-fly conversion to the ODGI format requires additional time!
    inputBinding:
      position: 101
      prefix: --input-graphs
  - id: optimize
    type:
      - 'null'
      - boolean
    doc: Compact the node ID space for each connected component before 
      squeezing.
    inputBinding:
      position: 101
      prefix: --optimize
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Print information about the progress to stderr.
    inputBinding:
      position: 101
      prefix: --progress
  - id: rank_suffix
    type:
      - 'null'
      - string
    doc: Add the separator and the input file rank as suffix to the path names 
      (to avoid path name collisions).
    inputBinding:
      position: 101
      prefix: --rank-suffix
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel operations.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: out
    type: File
    doc: Store all the input graphs in this file. The file name usually ends 
      with *.og*.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
