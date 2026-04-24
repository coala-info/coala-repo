cwlVersion: v1.2
class: CommandLineTool
baseCommand: adas-build
label: adas_adas-build
doc: "Build Hierarchical Navigable Small World Graphs (HNSW) with MinHash sketching\n
  \nTool homepage: https://github.com/jianshu93/adas"
inputs:
  - id: hnsw_ef
    type:
      - 'null'
      - int
    doc: HNSW ef parameter
    inputBinding:
      position: 101
      prefix: --hnsw-ef
  - id: input
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 101
      prefix: --input
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: Size of k-mers, must be ≤14
    inputBinding:
      position: 101
      prefix: --kmer-size
  - id: max_nb_connection
    type:
      - 'null'
      - int
    doc: HNSW max_nb_conn parameter
    inputBinding:
      position: 101
      prefix: --max_nb_connection
  - id: scale_modify_f
    type:
      - 'null'
      - float
    doc: scale modification factor in HNSW or HubNSW, must be in [0.2,1]
    inputBinding:
      position: 101
      prefix: --scale_modify_f
  - id: sketch_size
    type:
      - 'null'
      - int
    doc: Size of the sketch
    inputBinding:
      position: 101
      prefix: --sketch-size
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
stdout: adas_adas-build.out
