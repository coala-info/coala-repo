cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mccortex31
  - bubbles
label: mccortex_bubbles
doc: "Find bubbles in the graph, which are potential variants.\n\nThis wrapper runs the k<=31 binary (mccortex31). The same command exists in mccortex63 (k<=63), mccortex95 (k<=95) and mccortex127 (k<=127) with the same options; use those binaries for larger k-mer sizes.\n\nTool homepage: https://github.com/mcveanlab/mccortex"
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
    default: bubbles.txt.gz
    doc: Output bubble file (.txt.gz).
    inputBinding:
      position: 1
      prefix: --out
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
  - id: haploid
    type:
      - 'null'
      - string
    doc: List of haploid colours (for example the reference colour); '*' means all.
    inputBinding:
      position: 1
      prefix: --haploid
  - id: max_allele
    type:
      - 'null'
      - int
    doc: Maximum bubble branch length in k-mers (default 2000).
    inputBinding:
      position: 1
      prefix: --max-allele
  - id: max_flank
    type:
      - 'null'
      - int
    doc: Maximum flank length in k-mers (default 500).
    inputBinding:
      position: 1
      prefix: --max-flank
  - id: keep_serial
    type:
      - 'null'
      - boolean
    doc: Keep serial bubbles. Use if mapping is hard (more false positives).
    inputBinding:
      position: 1
      prefix: --keep-serial
  - id: graph
    type:
      type: array
      items: File
    doc: Input cortex graph file(s) (.ctx).
    inputBinding:
      position: 100
outputs:
  - id: bubbles_out
    type: File
    doc: Gzipped bubble calls.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mccortex:1.0--h24782f9_7
