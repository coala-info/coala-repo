cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ska
  - cov
label: ska2_cov
doc: "Estimate a coverage cutoff using a k-mer count profile (FASTQ only)\n\nTool homepage: https://github.com/bacpop/ska.rust"
inputs:
  - id: fastq_fwd
    type: File
    doc: 'FASTQ file (or .fastq.gz) with forward reads'
    inputBinding:
      position: 1
  - id: fastq_rev
    type: File
    doc: 'FASTQ file (or .fastq.gz) with reverse reads'
    inputBinding:
      position: 2
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: 'K-mer size [default: 31]'
    inputBinding:
      position: 101
      prefix: -k
  - id: single_strand
    type:
      - 'null'
      - boolean
    doc: 'Ignore reverse complement (all reads are oriented along same strand)'
    inputBinding:
      position: 101
      prefix: --single-strand
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Show progress messages'
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: 'Standard output'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ska2:0.5.1--h4349ce8_0
stdout: ska2_cov.out
