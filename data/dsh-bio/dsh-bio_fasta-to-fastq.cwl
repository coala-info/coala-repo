cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-bio_fasta-to-fastq
label: dsh-bio_fasta-to-fastq
doc: "Converts FASTA sequences to FASTQ format.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: default_quality
    type:
      - 'null'
      - int
    doc: Default quality score to assign to all bases if not specified in the 
      FASTA header. Default is 30.
    inputBinding:
      position: 102
      prefix: --default-quality
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite output file if it already exists.
    inputBinding:
      position: 102
      prefix: --force
  - id: quality_score_type
    type:
      - 'null'
      - string
    doc: Type of quality scores to generate (e.g., ILLUMINA, SOLEXA, SANGER). 
      Default is ILLUMINA.
    inputBinding:
      position: 102
      prefix: --quality-score-type
outputs:
  - id: output_fastq
    type: File
    doc: Output FASTQ file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
