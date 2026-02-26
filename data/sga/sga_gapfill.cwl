cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sga
  - gapfill
label: sga_gapfill
doc: "Fill in scaffold gaps using walks through a de Bruijn graph\n\nTool homepage:
  https://github.com/jts/sga"
inputs:
  - id: scaffolds_fa
    type: File
    doc: SCAFFOLDS.fa
    inputBinding:
      position: 1
  - id: end_kmer
    type:
      - 'null'
      - int
    doc: Last kmer size used to attempt to resolve each gap
    default: 51
    inputBinding:
      position: 102
      prefix: --end-kmer
  - id: kmer_threshold
    type:
      - 'null'
      - int
    doc: only use kmers seen at least T times
    inputBinding:
      position: 102
      prefix: --kmer-threshold
  - id: prefix
    type:
      - 'null'
      - string
    doc: load the FM-index with prefix NAME
    inputBinding:
      position: 102
      prefix: --prefix
  - id: sample_rate
    type:
      - 'null'
      - int
    doc: use occurrence array sample rate of N in the FM-index. Higher values 
      use significantly less memory at the cost of higher runtime. This value 
      must be a power of 2
    default: 128
    inputBinding:
      position: 102
      prefix: --sample-rate
  - id: start_kmer
    type:
      - 'null'
      - int
    doc: First kmer size used to attempt to resolve each gap
    default: 91
    inputBinding:
      position: 102
      prefix: --start-kmer
  - id: threads
    type:
      - 'null'
      - int
    doc: use NUM computation threads
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: display verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sga:v0.10.15-4-deb_cv1
stdout: sga_gapfill.out
