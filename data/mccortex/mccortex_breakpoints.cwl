cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mccortex31
  - breakpoints
label: mccortex_breakpoints
doc: "Use a trusted assembled genome to call large events. Output is gzipped.\n\nThis wrapper runs the k<=31 binary (mccortex31). The same command exists in mccortex63 (k<=63), mccortex95 (k<=95) and mccortex127 (k<=127) with the same options; use those binaries for larger k-mer sizes.\n\nTool homepage: https://github.com/mcveanlab/mccortex"
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
  - id: paths
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --paths
    doc: Link file (.ctp or .ctp.gz) to load. Can be given multiple times; use offset:file.ctp to choose the colour.
    inputBinding:
      position: 1
  - id: out
    type: string
    default: breakpoints.txt.gz
    doc: Output gzipped call file (.txt.gz).
    inputBinding:
      position: 1
      prefix: --out
  - id: seq
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --seq
    doc: Trusted input sequence (assembled genome). Can be given multiple times.
    inputBinding:
      position: 1
  - id: minref
    type:
      - 'null'
      - int
    doc: Require this many k-mers at the reference breakpoint (default 5).
    inputBinding:
      position: 1
      prefix: --minref
  - id: maxref
    type:
      - 'null'
      - int
    doc: Stop after this many k-mers at the reference breakpoint (default 1000).
    inputBinding:
      position: 1
      prefix: --maxref
  - id: no_ref_edges
    type:
      - 'null'
      - boolean
    doc: Do not load edges from the reference.
    inputBinding:
      position: 1
      prefix: --no-ref-edges
  - id: graph
    type:
      type: array
      items: File
    doc: Input cortex graph file(s) (.ctx).
    inputBinding:
      position: 100
outputs:
  - id: breakpoints_out
    type: File
    doc: Gzipped breakpoint calls.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mccortex:1.0--h24782f9_7
