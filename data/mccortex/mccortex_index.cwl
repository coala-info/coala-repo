cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mccortex31
  - index
label: mccortex_index
doc: "Index a sorted cortex graph file (sort it with `sort` first).\n\nThis wrapper runs the k<=31 binary (mccortex31). The same command exists in mccortex63 (k<=63), mccortex95 (k<=95) and mccortex127 (k<=127) with the same options; use those binaries for larger k-mer sizes.\n\nTool homepage: https://github.com/mcveanlab/mccortex"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.graph)
        writable: true
inputs:
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Silence status output normally printed to STDERR.
    inputBinding:
      position: 1
      prefix: --quiet
  - id: force
    type:
      - 'null'
      - boolean
    doc: 'Overwrite output files if they already exist. Known problem: in mccortex 1.0 this option makes `index` crash with a segmentation fault; leave it off.'
    inputBinding:
      position: 1
      prefix: --force
  - id: out
    type: string
    default: graph.ctx.idx
    doc: Output index file (.ctx.idx).
    inputBinding:
      position: 1
      prefix: --out
  - id: block_size
    type:
      - 'null'
      - string
    doc: Block of this many bytes (default 4MB).
    inputBinding:
      position: 1
      prefix: --block-size
  - id: block_kmers
    type:
      - 'null'
      - int
    doc: Block of this many k-mers.
    inputBinding:
      position: 1
      prefix: --block-kmers
  - id: graph
    type: File
    doc: Sorted input cortex graph file (.ctx); run `sort` first.
    inputBinding:
      position: 100
outputs:
  - id: graph_index
    type: File
    doc: Index file for the graph.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mccortex:1.0--h24782f9_7
