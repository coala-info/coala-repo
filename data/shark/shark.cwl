cwlVersion: v1.2
class: CommandLineTool
baseCommand: shark
label: shark
doc: "missing required files\n\nTool homepage: https://algolab.github.io/shark/"
inputs:
  - id: bf_size
    type:
      - 'null'
      - float
    doc: bloom filter size in GB (default:1)
    default: 1
    inputBinding:
      position: 101
      prefix: --bf-size
  - id: confidence
    type:
      - 'null'
      - float
    doc: confidence for associating a read to a gene (default:0.6)
    default: 0.6
    inputBinding:
      position: 101
      prefix: --confidence
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: size of the kmers to index (default:17, max:31)
    default: 17
    inputBinding:
      position: 101
      prefix: --kmer-size
  - id: min_base_quality
    type:
      - 'null'
      - int
    doc: minimum base quality (assume FASTQ Illumina 1.8+ Phred scale, 
      default:0, i.e., no filtering)
    default: 0
    inputBinding:
      position: 101
      prefix: --min-base-quality
  - id: reference
    type: File
    doc: reference sequences in FASTA format (can be gzipped)
    inputBinding:
      position: 101
      prefix: --reference
  - id: sample1
    type: File
    doc: sample in FASTQ (can be gzipped)
    inputBinding:
      position: 101
      prefix: --sample1
  - id: sample2
    type:
      - 'null'
      - File
    doc: second sample in FASTQ (optional, can be gzipped)
    inputBinding:
      position: 101
      prefix: --sample2
  - id: single
    type:
      - 'null'
      - boolean
    doc: report an association only if a single gene is found
    inputBinding:
      position: 101
      prefix: --single
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads (default:1)
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose mode
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: out1
    type:
      - 'null'
      - File
    doc: first output sample in FASTQ
    outputBinding:
      glob: $(inputs.out1)
  - id: out2
    type:
      - 'null'
      - File
    doc: second output sample in FASTQ
    outputBinding:
      glob: $(inputs.out2)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shark:1.2.0--h077b44d_5
