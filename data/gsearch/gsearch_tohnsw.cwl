cwlVersion: v1.2
class: CommandLineTool
baseCommand: gsearch
label: gsearch_tohnsw
doc: "Build HNSW/HubNSW graph database from a collection of database genomes based on MinHash-like metric\n\nTool homepage: https://github.com/jean-pierreBoth/gsearch"
arguments:
  - position: 10
    valueFrom: tohnsw
inputs:
  - id: algo
    type: string
    doc: "specifiy the algorithm to use for sketching: prob, super/super2, hll or optdens/revoptdens"
    inputBinding:
      position: 101
      prefix: --algo
  - id: aa
    type:
      - 'null'
      - boolean
    doc: "Specificy amino acid processing, require no value"
    inputBinding:
      position: 101
      prefix: --aa
  - id: block
    type:
      - 'null'
      - boolean
    doc: "sketching is done concatenating sequences"
    inputBinding:
      position: 101
      prefix: --block
  - id: hnsw_dir
    type: Directory
    doc: "directory containing the database genomes (fasta files, DNA or amino acid)"
    inputBinding:
      position: 101
      prefix: --dir
  - id: ef
    type:
      - 'null'
      - int
    doc: "ef_construct in HNSW"
    inputBinding:
      position: 101
      prefix: --ef
  - id: kmer_size
    type: int
    doc: "k-mer size to use"
    inputBinding:
      position: 101
      prefix: --kmer
  - id: neighbours
    type: int
    doc: "Maximum allowed number of neighbors (M) in HNSW"
    inputBinding:
      position: 101
      prefix: --nbng
  - id: scale_modify_f
    type:
      - 'null'
      - float
    doc: "scale modification factor in HNSW or HubNSW, must be in [0.2,1] (default 1.0)"
    inputBinding:
      position: 101
      prefix: --scale_modify_f
  - id: sketch_size
    type: int
    doc: "sketch size of minhash to use"
    inputBinding:
      position: 101
      prefix: --sketch
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
  - id: hnsw_graph
    type:
      - 'null'
      - File
    doc: HNSW graph dump
    outputBinding:
      glob: hnswdump.hnsw.graph
  - id: hnsw_data
    type:
      - 'null'
      - File
    doc: HNSW data dump (sketches)
    outputBinding:
      glob: hnswdump.hnsw.data
  - id: parameters
    type:
      - 'null'
      - File
    doc: HNSW and sketching parameters
    outputBinding:
      glob: parameters.json
  - id: processing_state
    type:
      - 'null'
      - File
    doc: File processing information
    outputBinding:
      glob: processing_state.json
  - id: seqdict
    type:
      - 'null'
      - File
    doc: Dictionary of genome ranks, ids and file names
    outputBinding:
      glob: seqdict.json
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gsearch:0.3.4--hafc0c1d_0
stdout: gsearch_tohnsw.out
stderr: gsearch_tohnsw.log
