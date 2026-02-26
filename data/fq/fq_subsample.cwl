cwlVersion: v1.2
class: CommandLineTool
baseCommand: fq subsample
label: fq_subsample
doc: "Outputs a subset of records\n\nTool homepage: https://github.com/stjude-rust-labs/fq"
inputs:
  - id: r1_src
    type: File
    doc: Read 1 source. Accepts both raw and gzipped FASTQ inputs
    inputBinding:
      position: 1
  - id: r2_src
    type:
      - 'null'
      - File
    doc: Read 2 source. Accepts both raw and gzipped FASTQ inputs
    inputBinding:
      position: 2
  - id: probability
    type:
      - 'null'
      - float
    doc: The probability a record is kept, as a percentage (0.0, 1.0). Cannot be
      used with `record-count`
    inputBinding:
      position: 103
      prefix: --probability
  - id: record_count
    type:
      - 'null'
      - int
    doc: The exact number of records to keep. Cannot be used with `probability`
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
  - id: r1_dst
    type: File
    doc: Read 1 destination. Output will be gzipped if ends in `.gz`
    outputBinding:
      glob: $(inputs.r1_dst)
  - id: r2_dst
    type:
      - 'null'
      - File
    doc: Read 2 destination. Output will be gzipped if ends in `.gz`
    outputBinding:
      glob: $(inputs.r2_dst)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fq:0.12.0--h9ee0642_0
