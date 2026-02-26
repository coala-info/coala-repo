cwlVersion: v1.2
class: CommandLineTool
baseCommand: bindashtree
label: bindashtree
doc: "Binwise Densified MinHash and Rapid Neighbor-joining Tree Construction\n\nTool
  homepage: https://github.com/jianshu93/bindashtree"
inputs:
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: Chunk size for RapidNJ/Hybrid methods
    default: 30
    inputBinding:
      position: 101
      prefix: --chunk_size
  - id: densification
    type:
      - 'null'
      - string
    doc: 'Densification strategy: 0=Optimal Densification, 1=Reverse Optimal Densification/faster
      Densification'
    default: '0'
    inputBinding:
      position: 101
      prefix: --densification
  - id: input
    type: File
    doc: Genome list file (one FASTA/FNA file per line), .gz supported
    inputBinding:
      position: 101
      prefix: --input
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: K-mer size
    default: 16
    inputBinding:
      position: 101
      prefix: --kmer_size
  - id: naive_percentage
    type:
      - 'null'
      - int
    doc: Percentage of steps naive for hybrid method
    default: 90
    inputBinding:
      position: 101
      prefix: --naive_percentage
  - id: sketch_size
    type:
      - 'null'
      - int
    doc: MinHash sketch size
    default: 10240
    inputBinding:
      position: 101
      prefix: --sketch_size
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use in parallel
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: tree_method
    type:
      - 'null'
      - string
    doc: 'Tree construction method: naive, rapidnj, hybrid'
    default: rapidnj
    inputBinding:
      position: 101
      prefix: --tree
outputs:
  - id: output_matrix
    type:
      - 'null'
      - File
    doc: Output the phylip distance matrix to a file
    outputBinding:
      glob: $(inputs.output_matrix)
  - id: output_tree
    type: File
    doc: Output the resulting tree in Newick format to a file
    outputBinding:
      glob: $(inputs.output_tree)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bindashtree:0.1.1--h3ab6199_0
