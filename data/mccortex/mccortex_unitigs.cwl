cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mccortex31
  - unitigs
label: mccortex_unitigs
doc: "Print unitigs (with k-1 bases of overlap) from a cortex graph in FASTA, GFA or DOT format.\n\nThis wrapper runs the k<=31 binary (mccortex31). The same command exists in mccortex63 (k<=63), mccortex95 (k<=95) and mccortex127 (k<=127) with the same options; use those binaries for larger k-mer sizes.\n\nTool homepage: https://github.com/mcveanlab/mccortex"
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
    default: unitigs.fa
    doc: Output file.
    inputBinding:
      position: 1
      prefix: --out
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: Print in FASTA format (default).
    inputBinding:
      position: 1
      prefix: --fasta
  - id: gfa
    type:
      - 'null'
      - boolean
    doc: Print in Graphical Fragment Assembly (GFA) format.
    inputBinding:
      position: 1
      prefix: --gfa
  - id: dot
    type:
      - 'null'
      - boolean
    doc: Print in graphviz (DOT) format.
    inputBinding:
      position: 1
      prefix: --dot
  - id: points
    type:
      - 'null'
      - boolean
    doc: With --dot, print contigs as points.
    inputBinding:
      position: 1
      prefix: --points
  - id: graph
    type:
      type: array
      items: File
    doc: Input cortex graph file(s) (.ctx).
    inputBinding:
      position: 100
outputs:
  - id: unitigs_out
    type: File
    doc: Unitigs.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mccortex:1.0--h24782f9_7
