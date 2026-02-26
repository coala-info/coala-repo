cwlVersion: v1.2
class: CommandLineTool
baseCommand: ntHits
label: nthits
doc: "Filters k-mers based on counts (cmin <= count <= cmax) in input files\n\nTool
  homepage: https://github.com/bcgsc/ntHits"
inputs:
  - id: out_type
    type: string
    doc: "Output format: Bloom filter 'bf', counting Bloom filter ('cbf'), or table
      ('table')"
    inputBinding:
      position: 1
  - id: files
    type:
      type: array
      items: File
    doc: Input files
    inputBinding:
      position: 2
  - id: error_rate
    type:
      - 'null'
      - float
    doc: Target Bloom filter error rate
    default: 0.0001
    inputBinding:
      position: 103
      prefix: --error-rate
  - id: frequencies
    type: File
    doc: Frequency histogram file (e.g. from ntCard)
    inputBinding:
      position: 103
      prefix: --frequencies
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: k-mer length, ignored if using spaced seeds (-s)
    default: 64
    inputBinding:
      position: 103
      prefix: --kmer-length
  - id: long_mode
    type:
      - 'null'
      - boolean
    doc: Optimize data reader for long sequences (>5kbp)
    inputBinding:
      position: 103
      prefix: --long-mode
  - id: max_count
    type:
      - 'null'
      - int
    doc: Maximum k-mer count (<=254)
    default: 254
    inputBinding:
      position: 103
      prefix: --max-count
  - id: min_count
    type:
      - 'null'
      - int
    doc: Minimum k-mer count (>=1), ignored if using --solid
    default: 1
    inputBinding:
      position: 103
      prefix: --min-count
  - id: num_hashes
    type:
      - 'null'
      - int
    doc: Number of hashes to generate per k-mer/spaced seed
    default: 3
    inputBinding:
      position: 103
      prefix: --num-hashes
  - id: seeds
    type:
      - 'null'
      - string
    doc: If specified, use spaced seeds (separate with commas, e.g. 10101,11011)
    inputBinding:
      position: 103
      prefix: --seeds
  - id: solid
    type:
      - 'null'
      - boolean
    doc: Automatically tune 'cmin' to filter out erroneous k-mers
    inputBinding:
      position: 103
      prefix: --solid
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of parallel threads
    default: 4
    inputBinding:
      position: 103
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - string
    doc: 'Level of details printed to stdout (-v: normal, -vv detailed)'
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: out_file
    type: File
    doc: Output file's name
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nthits:1.0.3--h4ac6f70_1
