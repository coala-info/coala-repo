cwlVersion: v1.2
class: CommandLineTool
baseCommand: ./gem-indexer
label: gem3-mapper_gem-indexer
doc: "Index a genome for GEM mapper\n\nTool homepage: https://github.com/smarco/gem3-mapper"
inputs:
  - id: bisulfite_index
    type:
      - 'null'
      - boolean
    doc: Create a bisulfite-converted index
    default: false
    inputBinding:
      position: 101
      prefix: --bisulfite-index
  - id: input_file
    type: File
    doc: Multi-FASTA file
    inputBinding:
      position: 101
      prefix: --input
  - id: output_prefix
    type: string
    doc: Prefix for output index files
    inputBinding:
      position: 101
      prefix: --output
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: '#cores'
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gem3-mapper:3.6.1--hb1d24b7_13
stdout: gem3-mapper_gem-indexer.out
