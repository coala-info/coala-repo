cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mccortex31
  - join
label: mccortex_join
doc: "Merge cortex graphs, optionally filtering by the k-mers of other graphs.\n\nThis wrapper runs the k<=31 binary (mccortex31). The same command exists in mccortex63 (k<=63), mccortex95 (k<=95) and mccortex127 (k<=127) with the same options; use those binaries for larger k-mer sizes.\n\nTool homepage: https://github.com/mcveanlab/mccortex"
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
    doc: Overwrite output files if they already exist.
    inputBinding:
      position: 1
      prefix: --force
  - id: memory
    type:
      - 'null'
      - string
    doc: Memory to use (for example 1GB, 500M, 20GB). Default 1GB.
    inputBinding:
      position: 1
      prefix: --memory
  - id: nkmers
    type:
      - 'null'
      - string
    doc: Number of hash table entries (for example 4M, 1G). Default 4M.
    inputBinding:
      position: 1
      prefix: --nkmers
  - id: out
    type: string
    default: joined.ctx
    doc: Output graph file (.ctx).
    inputBinding:
      position: 1
      prefix: --out
  - id: ncols
    type:
      - 'null'
      - int
    doc: How many colours to load at once (default 1).
    inputBinding:
      position: 1
      prefix: --ncols
  - id: intersect
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --intersect
    doc: Only load the k-mers that are in this graph. Can be given multiple times. The graph is not merged into the output.
    inputBinding:
      position: 1
  - id: sort
    type:
      - 'null'
      - boolean
    doc: Output a sorted graph file.
    inputBinding:
      position: 1
      prefix: --sort
  - id: graph
    type:
      type: array
      items: File
    doc: Input cortex graph files (.ctx), merged in order. The command line forms offset:file.ctx and file.ctx:2,3 (colour selection) are not available.
    inputBinding:
      position: 100
outputs:
  - id: graph_out
    type: File
    doc: Output cortex graph file (.ctx).
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mccortex:1.0--h24782f9_7
