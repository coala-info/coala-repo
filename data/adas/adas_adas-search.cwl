cwlVersion: v1.2
class: CommandLineTool
baseCommand: adas-search
label: adas_adas-search
doc: "Search against Pre-built Hierarchical Navigable Small World Graphs (HNSW) Index\n
  \nTool homepage: https://github.com/jianshu93/adas"
inputs:
  - id: hnsw
    type: Directory
    doc: directory contains pre-built HNSW database files
    inputBinding:
      position: 101
      prefix: --hnsw
  - id: input
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 101
      prefix: --input
  - id: nbng
    type: int
    doc: Number of search answers
    inputBinding:
      position: 101
      prefix: --nbng
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for sketching
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/adas:0.1.3--h3ab6199_0
stdout: adas_adas-search.out
