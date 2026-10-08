cwlVersion: v1.2
class: CommandLineTool
baseCommand: gsearch
label: gsearch_ann
doc: "Approximate Nearest Neighbor Embedding using UMAP-like algorithm\n\nTool homepage: https://github.com/jean-pierreBoth/gsearch"
arguments:
  - position: 10
    valueFrom: ann
inputs:
  - id: hnsw_dir
    type: Directory
    doc: "directory containing hnsw"
    inputBinding:
      position: 101
      prefix: --hnsw
  - id: stats
    type:
      - 'null'
      - boolean
    doc: "to get stats on nb neighbours"
    inputBinding:
      position: 101
      prefix: --stats
  - id: embed
    type:
      - 'null'
      - boolean
    doc: "--embed to do an embedding"
    inputBinding:
      position: 101
      prefix: --embed
  - id: pio
    type:
      - 'null'
      - int
    doc: "Parallel IO processing"
    inputBinding:
      position: 1
      prefix: --pio
  - id: nbthreads
    type:
      - 'null'
      - int
    doc: "Number of threads for sketching"
    inputBinding:
      position: 2
      prefix: --nbthreads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Log messages of the command
  - id: ann_files
    type:
      type: array
      items: File
    doc: Embedding and statistics files written by the command
    outputBinding:
      glob: ["*.csv", "*.json", "*.txt"]
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.hnsw_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gsearch:0.3.4--hafc0c1d_0
stdout: gsearch_ann.out
stderr: gsearch_ann.log
