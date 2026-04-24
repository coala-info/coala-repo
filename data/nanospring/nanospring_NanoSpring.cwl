cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanospring_NanoSpring
label: nanospring_NanoSpring
doc: "No input file specified\n\nTool homepage: https://github.com/qm2/NanoSpring"
inputs:
  - id: compress
    type:
      - 'null'
      - boolean
    doc: compress
    inputBinding:
      position: 101
      prefix: --compress
  - id: decompress
    type:
      - 'null'
      - boolean
    doc: decompress
    inputBinding:
      position: 101
      prefix: --decompress
  - id: decompression_memory
    type:
      - 'null'
      - int
    doc: attempt to set peak memory usage for decompression in GB (default 5 GB)
      by using disk-based sort for writing reads in the correct order. This is 
      only approximate and might have no effect at very low settings or with 
      large number of threads when another decompressor stage is the biggest 
      memory contributor. Very low values might lead to slight reduction in 
      speed.
    inputBinding:
      position: 101
      prefix: --decompression-memory
  - id: edge_thr
    type:
      - 'null'
      - int
    doc: the max number of edges allowed in a consensus graph
    inputBinding:
      position: 101
      prefix: --edge-thr
  - id: input_file
    type:
      - 'null'
      - File
    doc: input file name
    inputBinding:
      position: 101
      prefix: --input-file
  - id: kmer
    type:
      - 'null'
      - int
    doc: kmer size for the minhash
    inputBinding:
      position: 101
      prefix: --kmer
  - id: max_chain_iter
    type:
      - 'null'
      - int
    doc: the max number of partial chains during chaining for minimap2
    inputBinding:
      position: 101
      prefix: --max-chain-iter
  - id: minimap_k
    type:
      - 'null'
      - int
    doc: kmer size for the minimap2
    inputBinding:
      position: 101
      prefix: --minimap-k
  - id: minimap_w
    type:
      - 'null'
      - int
    doc: window size for the minimap2
    inputBinding:
      position: 101
      prefix: --minimap-w
  - id: num_hash
    type:
      - 'null'
      - int
    doc: number of hash functions for minhash
    inputBinding:
      position: 101
      prefix: --num-hash
  - id: num_threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: --num-threads
  - id: overlap_sketch_thr
    type:
      - 'null'
      - int
    doc: the overlap sketch threshold for minhash
    inputBinding:
      position: 101
      prefix: --overlap-sketch-thr
  - id: working_dir
    type:
      - 'null'
      - Directory
    doc: directory to create temporary files
    inputBinding:
      position: 101
      prefix: --working-dir
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanospring:0.2--h43eeafb_2
