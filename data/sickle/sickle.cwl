cwlVersion: v1.2
class: CommandLineTool
baseCommand: sickle
label: sickle
doc: "Windowed Adaptive Trimming for FASTQ files using quality\n\nTool homepage: http://github.com/mloesch/sickle"
inputs:
  - id: command
    type: string
    doc: "Trimming mode: 'pe' for paired-end or 'se' for single-end"
    inputBinding:
      position: 1
  - id: fastq_file
    type:
      - 'null'
      - File
    doc: Input FASTQ file (for 'se' or forward reads in 'pe')
    inputBinding:
      position: 102
      prefix: --fastq-file
  - id: gzip_output
    type:
      - 'null'
      - boolean
    doc: Output gzipped files
    inputBinding:
      position: 102
      prefix: --gzip-output
  - id: length_threshold
    type:
      - 'null'
      - int
    doc: Threshold to keep a read based on length after trimming
    inputBinding:
      position: 102
      prefix: --length-threshold
  - id: no_five_prime
    type:
      - 'null'
      - boolean
    doc: Don't do 5' trimming
    inputBinding:
      position: 102
      prefix: --no-five-prime
  - id: qual_threshold
    type:
      - 'null'
      - int
    doc: Threshold for trimming based on average quality in a window
    inputBinding:
      position: 102
      prefix: --qual-threshold
  - id: qual_type
    type: string
    doc: 'Type of quality values: sanger, solexa, or illumina'
    inputBinding:
      position: 102
      prefix: --qual-type
  - id: reverse_fastq_file
    type:
      - 'null'
      - File
    doc: Input reverse FASTQ file (for 'pe' mode)
    inputBinding:
      position: 102
      prefix: --pe-file2
  - id: trunc_n
    type:
      - 'null'
      - boolean
    doc: Truncate sequence at the first N
    inputBinding:
      position: 102
      prefix: --trunc-n
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output trimmed FASTQ file (for 'se' or forward reads in 'pe')
    outputBinding:
      glob: $(inputs.output_file)
  - id: output_pe2
    type:
      - 'null'
      - File
    doc: Output reverse trimmed FASTQ file (for 'pe' mode)
    outputBinding:
      glob: $(inputs.output_pe2)
  - id: output_single
    type:
      - 'null'
      - File
    doc: Output trimmed singles FASTQ file (for 'pe' mode)
    outputBinding:
      glob: $(inputs.output_single)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sickle:v1.33-1b1-deb_cv1
