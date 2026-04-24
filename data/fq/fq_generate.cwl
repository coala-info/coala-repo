cwlVersion: v1.2
class: CommandLineTool
baseCommand: fq_generate
label: fq_generate
doc: "Generates a random FASTQ file pair\n\nTool homepage: https://github.com/stjude-rust-labs/fq"
inputs:
  - id: r1_dst
    type: File
    doc: Read 1 destination. Output will be gzipped if ends in `.gz`
    inputBinding:
      position: 1
  - id: r2_dst
    type: File
    doc: Read 2 destination. Output will be gzipped if ends in `.gz`
    inputBinding:
      position: 2
  - id: read_length
    type:
      - 'null'
      - int
    doc: Number of bases in the sequence
    inputBinding:
      position: 103
      prefix: --read-length
  - id: record_count
    type:
      - 'null'
      - int
    doc: Number of records to generate
    inputBinding:
      position: 103
      prefix: --record-count
  - id: seed
    type:
      - 'null'
      - string
    doc: Seed to use for the random number generator
    inputBinding:
      position: 103
      prefix: --seed
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fq:0.12.0--h9ee0642_0
stdout: fq_generate.out
