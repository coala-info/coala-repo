cwlVersion: v1.2
class: CommandLineTool
baseCommand: metamaps_index
label: metamaps_index
doc: "Index a reference genome for mapping.\n\nTool homepage: https://github.com/DiltheyLab/MetaMaps"
inputs:
  - id: index
    type: string
    doc: output prefix for index
    inputBinding:
      position: 101
      prefix: --index
  - id: kmer
    type:
      - 'null'
      - int
    doc: kmer size <= 16
    default: 16
    inputBinding:
      position: 101
      prefix: --kmer
  - id: maxmemory
    type:
      - 'null'
      - string
    doc: maximum memory, in GB
    inputBinding:
      position: 101
      prefix: --maxmemory
  - id: min_read_len
    type:
      - 'null'
      - int
    doc: minimum read length to map
    default: 1000
    inputBinding:
      position: 101
      prefix: --minReadLen
  - id: perc_identity
    type:
      - 'null'
      - int
    doc: threshold for identity
    default: 80
    inputBinding:
      position: 101
      prefix: --perc_identity
  - id: pval
    type:
      - 'null'
      - string
    doc: p-value cutoff, used to determine window/sketch sizes
    default: e-03
    inputBinding:
      position: 101
      prefix: --pval
  - id: reference
    type: File
    doc: an input reference file (fasta/fastq)[.gz]
    inputBinding:
      position: 101
      prefix: --reference
  - id: threads
    type:
      - 'null'
      - int
    doc: count of threads for parallel execution
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: window
    type:
      - 'null'
      - int
    doc: window size. P-value is not considered if a window value is provided. 
      Lower window dow size implies denser sketch
    inputBinding:
      position: 101
      prefix: --window
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metamaps:0.1.98102e9--h21ec9f0_2
stdout: metamaps_index.out
