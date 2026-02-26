cwlVersion: v1.2
class: CommandLineTool
baseCommand: odgi build
label: odgi_build
doc: "Construct a dynamic succinct variation graph in ODGI format from a GFAv1.\n\n\
  Tool homepage: https://github.com/vgteam/odgi"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Verbosely print graph information to stderr. This includes the maximum 
      node_id, the minimum node_id, the handle to node_id mapping, the deleted 
      nodes and the path metadata.
    inputBinding:
      position: 101
      prefix: --debug
  - id: gfa_file
    type: File
    doc: GFAv1 FILE containing the nodes, edges and paths to build a dynamic 
      succinct variation graph from.
    inputBinding:
      position: 101
      prefix: --gfa
  - id: optimize
    type:
      - 'null'
      - boolean
    doc: Compact the graph id space into a dense integer range.
    inputBinding:
      position: 101
      prefix: --optimize
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Write the current progress to stderr.
    inputBinding:
      position: 101
      prefix: --progress
  - id: sort
    type:
      - 'null'
      - boolean
    doc: Apply a general topological sort to the graph and order the node ids 
      accordingly. A bidirected adaptation of Kahn’s topological sort (1962) is 
      used, which can handle components with no heads or tails. Here, both heads
      and tails are taken into account.
    inputBinding:
      position: 101
      prefix: --sort
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel operations.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_file
    type: File
    doc: Write the dynamic succinct variation graph to this *FILE*. A file 
      ending with *.og* is recommended.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
