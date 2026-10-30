cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mccortex31
  - server
label: mccortex_server
doc: "Query the graph by commands read from STDIN and answer with JSON on STDOUT. Here the commands are read from a file.\n\nThis wrapper runs the k<=31 binary (mccortex31). The same command exists in mccortex63 (k<=63), mccortex95 (k<=95) and mccortex127 (k<=127) with the same options; use those binaries for larger k-mer sizes.\n\nTool homepage: https://github.com/mcveanlab/mccortex"
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
    doc: Memory to use (for example 1GB).
    inputBinding:
      position: 1
      prefix: --memory
  - id: nkmers
    type:
      - 'null'
      - string
    doc: Number of hash table entries (for example 4M).
    inputBinding:
      position: 1
      prefix: --nkmers
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
  - id: single_line
    type:
      - 'null'
      - boolean
    doc: Responses on a single line.
    inputBinding:
      position: 1
      prefix: --single-line
  - id: coverages
    type:
      - 'null'
      - boolean
    doc: Load coverages for k-mers and links.
    inputBinding:
      position: 1
      prefix: --coverages
  - id: edges
    type:
      - 'null'
      - boolean
    doc: Load per sample edges.
    inputBinding:
      position: 1
      prefix: --edges
  - id: disk
    type:
      - 'null'
      - boolean
    doc: Read from disk (one graph only, must be sorted).
    inputBinding:
      position: 1
      prefix: --disk
  - id: queries
    type: File
    doc: 'Text file of queries read on STDIN, one per line: ''info'', ''random'' or a k-mer such as ACACCAA.'
  - id: graph
    type:
      type: array
      items: File
    doc: Input cortex graph file(s) (.ctx).
    inputBinding:
      position: 100
outputs:
  - id: responses
    type: stdout
    doc: JSON responses to the queries.
stdin: $(inputs.queries.path)
stdout: mccortex_server.json
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mccortex:1.0--h24782f9_7
