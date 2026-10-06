cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - abeona
  - subgraphs
label: abeona_subgraphs
doc: "Partition cortex graph into its subgraphs. Writes g<N>.traverse.ctx and\
  \ g<N>.traverse.ctx.json (junction count) per subgraph.\n\nTool homepage: https://github.com/winni2k/abeona"
inputs:
  - id: graph
    type: File
    doc: Input cortex graph (.ctx)
    inputBinding:
      position: 1
  - id: out_dir
    type: string
    default: subgraphs
    doc: Output directory
    inputBinding:
      position: 2
  - id: memory
    type:
      - 'null'
      - int
    doc: 'Maximum memory in giga bytes (default: 3)'
    inputBinding:
      position: 102
      prefix: --memory
  - id: cores
    type:
      - 'null'
      - int
    doc: 'Number of cores (default: 2)'
    inputBinding:
      position: 102
      prefix: --cores
  - id: initial_contigs
    type:
      - 'null'
      - File
    doc: 'Only start assembly from contigs in this FASTA'
    inputBinding:
      position: 102
      prefix: --initial-contigs
outputs:
  - id: subgraphs
    type: File[]
    doc: One cortex graph per subgraph
    outputBinding:
      glob: $(inputs.out_dir)/g*.traverse.ctx
  - id: subgraph_info
    type: File[]
    doc: Junction count per subgraph (JSON)
    outputBinding:
      glob: $(inputs.out_dir)/g*.traverse.ctx.json
  - id: output_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/abeona:0.45.0--py36_0
