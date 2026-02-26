cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gsearch
  - tohnsw
label: gsearch_tohnsw
doc: "Build HNSW/HubNSW graph database from a collection of database genomes based
  on MinHash-like metric\n\nTool homepage: https://github.com/jean-pierreBoth/gsearch"
inputs:
  - id: amino_acid_processing
    type:
      - 'null'
      - boolean
    doc: Specificy amino acid processing, require no value
    inputBinding:
      position: 101
      prefix: --aa
  - id: block_sketching
    type:
      - 'null'
      - boolean
    doc: sketching is done concatenating sequences
    inputBinding:
      position: 101
      prefix: --block
  - id: ef
    type:
      - 'null'
      - int
    doc: ef_construct in HNSW
    inputBinding:
      position: 101
      prefix: --ef
  - id: hnsw_dir
    type: Directory
    doc: directory for storing database genomes
    inputBinding:
      position: 101
      prefix: --dir
  - id: kmer_size
    type: int
    doc: k-mer size to use
    inputBinding:
      position: 101
      prefix: --kmer
  - id: neighbours
    type: int
    doc: Maximum allowed number of neighbors (M) in HNSW
    inputBinding:
      position: 101
      prefix: --nbng
  - id: scale_modify_f
    type:
      - 'null'
      - float
    doc: scale modification factor in HNSW or HubNSW, must be in [0.2,1]
    default: 1.0
    inputBinding:
      position: 101
      prefix: --scale_modify_f
  - id: sketch_algo
    type: string
    doc: 'specifiy the algorithm to use for sketching: prob, super/super2, hll or
      optdens/revoptdens'
    inputBinding:
      position: 101
      prefix: --algo
  - id: sketch_size
    type: int
    doc: sketch size of minhash to use
    inputBinding:
      position: 101
      prefix: --sketch
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gsearch:0.3.4--hafc0c1d_0
stdout: gsearch_tohnsw.out
