cwlVersion: v1.2
class: CommandLineTool
baseCommand: BubbleFinder
label: bubblefinder_BubbleFinder
doc: "Compute and output the SPQR tree of the input graph\n\nTool homepage: https://github.com/algbio/BubbleFinder"
inputs:
  - id: command
    type: string
    doc: Command to execute (superbubbles, directed-superbubbles, snarls, 
      ultrabubbles, spqr-tree)
    inputBinding:
      position: 1
  - id: clsd_trees_file
    type:
      - 'null'
      - File
    doc: Write CLSD superbubble trees (ultrabubble hierarchy) to <file> 
      (ultrabubbles command only)
    inputBinding:
      position: 102
      prefix: --clsd-trees
  - id: force_gfa_bidirected
    type:
      - 'null'
      - boolean
    doc: Force GFA input (bidirected)
    inputBinding:
      position: 102
      prefix: --gfa
  - id: force_gfa_directed
    type:
      - 'null'
      - boolean
    doc: Force GFA input interpreted as directed graph
    inputBinding:
      position: 102
      prefix: --gfa-directed
  - id: force_graph_format
    type:
      - 'null'
      - boolean
    doc: Force .graph text format (see 'Format options' above)
    inputBinding:
      position: 102
      prefix: --graph
  - id: graph_file
    type: File
    doc: Input graph file (possibly compressed)
    inputBinding:
      position: 102
      prefix: --gfa
  - id: stack_size
    type:
      - 'null'
      - string
    doc: Stack size in bytes
    inputBinding:
      position: 102
      prefix: -m
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 102
      prefix: -j
outputs:
  - id: output_file
    type: File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
  - id: report_json_file
    type:
      - 'null'
      - File
    doc: Write JSON metrics report
    outputBinding:
      glob: $(inputs.report_json_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bubblefinder:1.0.3--h503566f_0
