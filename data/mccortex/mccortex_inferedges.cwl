cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mccortex31
  - inferedges
label: mccortex_inferedges
doc: "Infer edges between k-mers that share k-1 bases. Run this before read threading (`thread`).\n\nThis wrapper runs the k<=31 binary (mccortex31). The same command exists in mccortex63 (k<=63), mccortex95 (k<=95) and mccortex127 (k<=127) with the same options; use those binaries for larger k-mer sizes.\n\nTool homepage: https://github.com/mcveanlab/mccortex"
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
    default: inferred.ctx
    doc: Output graph file (.ctx).
    inputBinding:
      position: 1
      prefix: --out
  - id: pop
    type:
      - 'null'
      - boolean
    doc: Add only edges that exist in at least one other sample of the population.
    inputBinding:
      position: 1
      prefix: --pop
  - id: all
    type:
      - 'null'
      - boolean
    doc: Add all missing edges (default).
    inputBinding:
      position: 1
      prefix: --all
  - id: graph
    type: File
    doc: Input population cortex graph file (.ctx).
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
