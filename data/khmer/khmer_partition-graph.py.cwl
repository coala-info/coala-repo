cwlVersion: v1.2
class: CommandLineTool
baseCommand: khmer_partition-graph.py
label: khmer_partition-graph.py
doc: "Partition a k-mer graph (Compact De Bruijn Graph) into disconnected components.\n
  \nTool homepage: https://khmer.readthedocs.io/"
inputs:
  - id: graphname
    type: File
    doc: The name of the input k-mer graph (typically a .ct or .oxigraph file).
    inputBinding:
      position: 1
  - id: ksize
    type:
      - 'null'
      - int
    doc: k-mer size to use.
    inputBinding:
      position: 102
      prefix: --ksize
  - id: min_tablesize
    type:
      - 'null'
      - float
    doc: Lower bound on tablesize to use.
    inputBinding:
      position: 102
      prefix: --min-tablesize
  - id: n_tables
    type:
      - 'null'
      - int
    doc: Number of tables to use for the count-graph.
    inputBinding:
      position: 102
      prefix: --n_tables
  - id: stop_early
    type:
      - 'null'
      - boolean
    doc: Stop after the first partition is found.
    inputBinding:
      position: 102
      prefix: --stop-early
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
stdout: khmer_partition-graph.py.out
