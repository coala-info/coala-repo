cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mccortex31
  - check
label: mccortex_check
doc: "Load a graph into memory along with any link files to check they are valid. The status report goes to STDERR and is saved as a log file.\n\nThis wrapper runs the k<=31 binary (mccortex31). The same command exists in mccortex63 (k<=63), mccortex95 (k<=95) and mccortex127 (k<=127) with the same options; use those binaries for larger k-mer sizes.\n\nTool homepage: https://github.com/mcveanlab/mccortex"
inputs:
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Silence status output normally printed to STDERR.
    inputBinding:
      position: 1
      prefix: --quiet
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
  - id: no_edge_check
    type:
      - 'null'
      - boolean
    doc: Do not check k-mer edges.
    inputBinding:
      position: 1
      prefix: --no-edge-check
  - id: graph
    type: File
    doc: Cortex graph file (.ctx) to check.
    inputBinding:
      position: 100
outputs:
  - id: log
    type: stderr
    doc: Status and check report printed by mccortex.
stderr: mccortex_check.log
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mccortex:1.0--h24782f9_7
