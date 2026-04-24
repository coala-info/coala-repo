cwlVersion: v1.2
class: CommandLineTool
baseCommand: adas-insert
label: adas_adas-insert
doc: "Insert into Pre-built Hierarchical Navigable Small World Graphs (HNSW) Index\n
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
stdout: adas_adas-insert.out
