cwlVersion: v1.2
class: CommandLineTool
baseCommand: gsearch
label: gsearch_request
doc: "Request nearest neighbors of query genomes against a pre-built HNSW graph database/index\n\nTool homepage: https://github.com/jean-pierreBoth/gsearch"
arguments:
  - position: 10
    valueFrom: request
inputs:
  - id: hnsw_dir
    type: Directory
    doc: "directory contains pre-built database files"
    inputBinding:
      position: 101
      prefix: --hnsw
  - id: nb_answers
    type: int
    doc: "Sets the number of neighbors for the query"
    inputBinding:
      position: 101
      prefix: --nbanswers
  - id: request_dir
    type: Directory
    doc: "Sets the directory of request genomes"
    inputBinding:
      position: 101
      prefix: --query
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
  - id: neighbors
    type:
      - 'null'
      - File
    doc: Table with query genome, database genome and distance
    outputBinding:
      glob: gsearch.neighbors.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gsearch:0.3.4--hafc0c1d_0
stdout: gsearch_request.out
stderr: gsearch_request.log
