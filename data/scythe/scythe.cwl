cwlVersion: v1.2
class: CommandLineTool
baseCommand: scythe
label: scythe
doc: "A Bayesian adapter trimmer that uses a Naive Bayes classifier to determine the
  most likely point of adapter contamination in sequence reads.\n\nTool homepage:
  https://github.com/michaelfeathers/scythe"
inputs:
  - id: input_fastq
    type: File
    doc: Input FASTQ file
    inputBinding:
      position: 1
  - id: adapters
    type: File
    doc: Adapter file (FASTA format)
    inputBinding:
      position: 102
      prefix: --adapters
  - id: matches_file
    type:
      - 'null'
      - File
    doc: File to write matching information to
    inputBinding:
      position: 102
      prefix: --matches-file
  - id: min_keep
    type:
      - 'null'
      - int
    doc: Minimum length of read to keep after trimming
    inputBinding:
      position: 102
      prefix: --min-keep
  - id: min_match
    type:
      - 'null'
      - int
    doc: Minimum match length
    default: 5
    inputBinding:
      position: 102
      prefix: --min-match
  - id: prior
    type:
      - 'null'
      - float
    doc: Prior contamination rate
    default: 0.05
    inputBinding:
      position: 102
      prefix: --prior
  - id: quality_type
    type:
      - 'null'
      - string
    doc: "Quality type: 'sanger', 'solexa', or 'illumina' (default: sanger)"
    inputBinding:
      position: 102
      prefix: --quality-type
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't print progress/summary information
    inputBinding:
      position: 102
      prefix: --quiet
  - id: tag
    type:
      - 'null'
      - boolean
    doc: Add a tag to the header of trimmed reads
    inputBinding:
      position: 102
      prefix: --tag
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/scythe:v0.994-4-deb_cv1
