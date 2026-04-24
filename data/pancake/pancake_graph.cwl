cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pancake
  - graph
label: pancake_graph
doc: "Generate a DOT graph from PanCake Data Object Files\n\nTool homepage: https://github.com/pancakeswap/pancake-frontend"
inputs:
  - id: all
    type:
      - 'null'
      - boolean
    doc: if set, all chromosomes contained in PAN_FILE appear in output (irrespective
      to CHROMS), DEFAULT=False
    inputBinding:
      position: 101
      prefix: -all
  - id: chroms
    type:
      - 'null'
      - type: array
        items: string
    doc: Chromosomes in Output (by default all chromosomes covered in PAN_FILE)
    inputBinding:
      position: 101
      prefix: --chroms
  - id: max_edges
    type:
      - 'null'
      - int
    doc: 'Maximal number of edges in output graph. (DEFAULT=10,000): if exceeded,
      PanCake will warn and interrupt!'
    inputBinding:
      position: 101
      prefix: --max_edges
  - id: max_entries
    type:
      - 'null'
      - int
    doc: 'Shared features are truncated in output if number of contained feature instances
      > MAX_ENTRIES (DEFAULT: MAX_ENTRIES=50)'
    inputBinding:
      position: 101
      prefix: --max_entries
  - id: max_nodes
    type:
      - 'null'
      - int
    doc: 'Maximal number of nodes in output graph. (DEFAULT=10,000): if exceeded,
      PanCake will warn and interrupt!'
    inputBinding:
      position: 101
      prefix: --max_nodes
  - id: pan_file
    type: File
    doc: Name of PanCake Data Object File (required)
    inputBinding:
      position: 101
      prefix: --panfile
  - id: regions
    type:
      - 'null'
      - boolean
    doc: if set, only specified regions are shown in output (DEFAULT=False), ignored
      if -all is set
    inputBinding:
      position: 101
      prefix: -regions
  - id: starts
    type:
      - 'null'
      - type: array
        items: int
    doc: Start positions (in same order as chromosomes), DEFAULT=1 on all chromosomes
    inputBinding:
      position: 101
      prefix: -starts
  - id: stops
    type:
      - 'null'
      - type: array
        items: int
    doc: Stop positions (in same order as chromosomes), DEFAULT=length of chromosomes
    inputBinding:
      position: 101
      prefix: -stops
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: 'output DOT file (DEFAULT: STDOUT)'
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pancake:1.1.2--py35_0
