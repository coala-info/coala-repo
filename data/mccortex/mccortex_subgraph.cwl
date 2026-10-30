cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mccortex31
  - subgraph
label: mccortex_subgraph
doc: "Load graphs and dump a graph containing all k-mers within a distance of the seed k-mers.\n\nThis wrapper runs the k<=31 binary (mccortex31). The same command exists in mccortex63 (k<=63), mccortex95 (k<=95) and mccortex127 (k<=127) with the same options; use those binaries for larger k-mer sizes.\n\nTool homepage: https://github.com/mcveanlab/mccortex"
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
    default: subgraph.ctx
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
  - id: seq
    type:
      type: array
      items: File
      inputBinding:
        prefix: --seq
    doc: Seed file (FASTA/FASTQ). At least one is required; seed files cannot be pipes.
    inputBinding:
      position: 1
  - id: dist
    type:
      - 'null'
      - int
    doc: Number of k-mers to extend by (default 0).
    inputBinding:
      position: 1
      prefix: --dist
  - id: invert
    type:
      - 'null'
      - boolean
    doc: Dump k-mers that are not in the subgraph.
    inputBinding:
      position: 1
      prefix: --invert
  - id: unitigs
    type:
      - 'null'
      - boolean
    doc: Grab entire runs of k-mers that are touched by a read.
    inputBinding:
      position: 1
      prefix: --unitigs
  - id: graph
    type:
      type: array
      items: File
    doc: Input cortex graph file(s) (.ctx). The form file.ctx:cols is not available.
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
