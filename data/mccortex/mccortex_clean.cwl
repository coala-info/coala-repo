cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mccortex31
  - clean
label: mccortex_clean
doc: "Clean errors from a graph (tip clipping and removal of low coverage unitigs). Joins graphs first if several inputs are given; a multisample graph is cleaned per sample against the merged population.\n\nThis wrapper runs the k<=31 binary (mccortex31). The same command exists in mccortex63 (k<=63), mccortex95 (k<=95) and mccortex127 (k<=127) with the same options; use those binaries for larger k-mer sizes.\n\nTool homepage: https://github.com/mcveanlab/mccortex"
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
    default: cleaned.ctx
    doc: Output graph file (.ctx).
    inputBinding:
      position: 1
      prefix: --out
  - id: ncols
    type:
      - 'null'
      - int
    doc: Number of graph colours to use.
    inputBinding:
      position: 1
      prefix: --ncols
  - id: sort
    type:
      - 'null'
      - boolean
    doc: Output a graph file ordered by k-mer.
    inputBinding:
      position: 1
      prefix: --sort
  - id: tips
    type:
      - 'null'
      - int
    doc: 'Clip tips shorter than this many k-mers (default: auto, 2*k). Use 0 to turn tip clipping off.'
    inputBinding:
      position: 1
      prefix: --tips=
      separate: false
  - id: unitigs
    type:
      - 'null'
      - int
    doc: 'Remove low coverage unitigs with median coverage below this value (default: auto threshold). Use 0 to turn off.'
    inputBinding:
      position: 1
      prefix: --unitigs=
      separate: false
  - id: fallback
    type:
      - 'null'
      - int
    doc: Fall back threshold if the unitig threshold cannot be picked.
    inputBinding:
      position: 1
      prefix: --fallback
  - id: covg_before
    type:
      - 'null'
      - string
    doc: Save k-mer coverage histogram before cleaning (CSV).
    inputBinding:
      position: 1
      prefix: --covg-before
  - id: covg_after
    type:
      - 'null'
      - string
    doc: Save k-mer coverage histogram after cleaning (CSV).
    inputBinding:
      position: 1
      prefix: --covg-after
  - id: len_before
    type:
      - 'null'
      - string
    doc: Save unitig length histogram before cleaning (CSV).
    inputBinding:
      position: 1
      prefix: --len-before
  - id: len_after
    type:
      - 'null'
      - string
    doc: Save unitig length histogram after cleaning (CSV).
    inputBinding:
      position: 1
      prefix: --len-after
  - id: graph
    type:
      type: array
      items: File
    doc: Input cortex graph file(s) (.ctx). Several files are joined first.
    inputBinding:
      position: 100
outputs:
  - id: graph_out
    type: File
    doc: Cleaned cortex graph file.
    outputBinding:
      glob: $(inputs.out)
  - id: covg_before_file
    type:
      - 'null'
      - File
    doc: Save k-mer coverage histogram before cleaning (CSV).
    outputBinding:
      glob: $(inputs.covg_before)
  - id: covg_after_file
    type:
      - 'null'
      - File
    doc: Save k-mer coverage histogram after cleaning (CSV).
    outputBinding:
      glob: $(inputs.covg_after)
  - id: len_before_file
    type:
      - 'null'
      - File
    doc: Save unitig length histogram before cleaning (CSV).
    outputBinding:
      glob: $(inputs.len_before)
  - id: len_after_file
    type:
      - 'null'
      - File
    doc: Save unitig length histogram after cleaning (CSV).
    outputBinding:
      glob: $(inputs.len_after)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mccortex:1.0--h24782f9_7
