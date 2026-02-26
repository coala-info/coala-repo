cwlVersion: v1.2
class: CommandLineTool
baseCommand: gsearch request
label: gsearch_request
doc: "Request nearest neighbors of query genomes against a pre-built HNSW graph database/index\n\
  \nTool homepage: https://github.com/jean-pierreBoth/gsearch"
inputs:
  - id: hnsw_dir
    type: Directory
    doc: directory contains pre-built database files
    inputBinding:
      position: 101
      prefix: --hnsw
  - id: nb_answers
    type: int
    doc: Sets the number of neighbors for the query
    inputBinding:
      position: 101
      prefix: --nbanswers
  - id: request_dir
    type: Directory
    doc: Sets the directory of request genomes
    inputBinding:
      position: 101
      prefix: --query
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gsearch:0.3.4--hafc0c1d_0
stdout: gsearch_request.out
