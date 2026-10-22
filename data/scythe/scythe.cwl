cwlVersion: v1.2
class: CommandLineTool
baseCommand: scythe
label: scythe
doc: "A Bayesian adapter trimmer that uses a Naive Bayes classifier to determine the
  most likely point of adapter contamination in sequence reads.\n\nTool homepage:
  https://github.com/vsbuffalo/scythe"
inputs:
  - id: input_fastq
    type: File
    doc: Input FASTQ file
    inputBinding:
      position: 200
  - id: adapters
    type: File
    doc: Adapter file (FASTA format)
    inputBinding:
      position: 102
      prefix: -a
  - id: matches_file
    type:
      - 'null'
      - string
    doc: 'File to write matching information to (default: no output)'
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
    inputBinding:
      position: 102
      prefix: --min-match
  - id: prior
    type:
      - 'null'
      - float
    doc: Prior contamination rate
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
  - id: output_file_path
    type: string
    doc: Output trimmed sequences file
    inputBinding:
      position: 103
      prefix: -o
outputs:
  - id: matches_output
    type:
      - 'null'
      - File
    doc: Matches file written with --matches-file
    outputBinding:
      glob: $(inputs.matches_file)
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/scythe:v0.994-4-deb_cv1
