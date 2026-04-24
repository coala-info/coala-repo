cwlVersion: v1.2
class: CommandLineTool
baseCommand: dartunifrac
label: dartunifrac
doc: "Approximate UniFrac via Weighted MinHash 🎯🎯🎯\n\nTool homepage: https://github.com/jianshu93/DartUniFrac"
inputs:
  - id: bbits
    type:
      - 'null'
      - int
    doc: 'Extracting lower bits from hashes. Supported: 16 (default), 32, 64.'
    inputBinding:
      position: 101
      prefix: --bbits
  - id: biom
    type:
      - 'null'
      - File
    doc: OTU/Feature table in BIOM (HDF5) format
    inputBinding:
      position: 101
      prefix: --biom
  - id: block
    type:
      - 'null'
      - int
    doc: Number of rows per chunk, streaming mode only
    inputBinding:
      position: 101
      prefix: --block
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Compress output with zstd, .zst suffix will be added to the output file
      name
    inputBinding:
      position: 101
      prefix: --compress
  - id: input
    type:
      - 'null'
      - File
    doc: OTU/Feature table in TSV format
    inputBinding:
      position: 101
      prefix: --input
  - id: method
    type:
      - 'null'
      - string
    doc: 'Sketching method: dmh (DartMinHash) or ers (Efficient Rejection Sampling)'
    inputBinding:
      position: 101
      prefix: --method
  - id: pcoa
    type:
      - 'null'
      - boolean
    doc: Fast Principal Coordinate Analysis based on Randomized SVD (subspace 
      iteration), output saved to pcoa.txt/ordination.txt
    inputBinding:
      position: 101
      prefix: --pcoa
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed for reproducibility
    inputBinding:
      position: 101
      prefix: --seed
  - id: seq_length
    type:
      - 'null'
      - int
    doc: Per-hash independent random sequence length for ERS, must be >= 512
    inputBinding:
      position: 101
      prefix: --length
  - id: sketch_size
    type:
      - 'null'
      - int
    doc: Sketch size for Weighted MinHash (DartMinHash or ERS)
    inputBinding:
      position: 101
      prefix: --sketch
  - id: streaming
    type:
      - 'null'
      - boolean
    doc: Streaming the distance matrix while computing (zstd-compressed)
    inputBinding:
      position: 101
      prefix: --streaming
  - id: succ
    type:
      - 'null'
      - boolean
    doc: Use succparen balanced-parentheses tree representation
    inputBinding:
      position: 101
      prefix: --succ
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads, default all logical cores
    inputBinding:
      position: 101
      prefix: --threads
  - id: tree
    type: File
    doc: Input tree in Newick format
    inputBinding:
      position: 101
      prefix: --tree
  - id: weighted
    type:
      - 'null'
      - boolean
    doc: Weighted UniFrac (normalized)
    inputBinding:
      position: 101
      prefix: --weighted
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output distance matrix in TSV format
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dartunifrac:0.3.0--h3dc2dae_0
