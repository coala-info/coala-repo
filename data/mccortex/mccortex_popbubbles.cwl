cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mccortex31
  - popbubbles
label: mccortex_popbubbles
doc: "Pop bubbles in the graph. All graphs are loaded and treated as one colour for bubble popping; the output is a multicolour graph.\n\nThis wrapper runs the k<=31 binary (mccortex31). The same command exists in mccortex63 (k<=63), mccortex95 (k<=95) and mccortex127 (k<=127) with the same options; use those binaries for larger k-mer sizes.\n\nTool homepage: https://github.com/mcveanlab/mccortex"
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
  - id: threads
    type:
      - 'null'
      - int
    doc: Limit on processing threads (default 2).
    inputBinding:
      position: 1
      prefix: --threads
  - id: out
    type: string
    default: popped.ctx
    doc: Output graph file (.ctx).
    inputBinding:
      position: 1
      prefix: --out
  - id: max_covg
    type:
      - 'null'
      - int
    doc: Only remove branches whose mean coverage is below this value.
    inputBinding:
      position: 1
      prefix: --max-covg
  - id: max_len
    type:
      - 'null'
      - int
    doc: Only remove branches shorter than this many k-mers.
    inputBinding:
      position: 1
      prefix: --max-len
  - id: max_diff
    type:
      - 'null'
      - int
    doc: Only pop bubbles whose branch lengths are within this many k-mers.
    inputBinding:
      position: 1
      prefix: --max-diff
  - id: graph
    type:
      type: array
      items: File
    doc: Input cortex graph file(s) (.ctx).
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
