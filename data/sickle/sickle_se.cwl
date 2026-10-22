cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sickle
  - se
label: sickle_se
doc: "Single-end sequence trimming: windowed adaptive trimming of FASTQ files using
  quality.\n\nTool homepage: https://github.com/najoshi/sickle"
inputs:
  - id: fastq_file
    type: File
    doc: Input fastq file
    inputBinding:
      position: 1
      prefix: -f
  - id: qual_type
    type: string
    doc: Type of quality values (solexa (CASAVA < 1.3), illumina (CASAVA 1.3 to
      1.7), sanger (which is CASAVA >= 1.8))
    inputBinding:
      position: 2
      prefix: -t
  - id: output_file
    type: string
    doc: Output trimmed fastq file
    inputBinding:
      position: 3
      prefix: -o
  - id: qual_threshold
    type:
      - 'null'
      - int
    doc: Threshold for trimming based on average quality in a window. Default 20.
    inputBinding:
      position: 4
      prefix: -q
  - id: length_threshold
    type:
      - 'null'
      - int
    doc: Threshold to keep a read based on length after trimming. Default 20.
    inputBinding:
      position: 4
      prefix: -l
  - id: no_fiveprime
    type:
      - 'null'
      - boolean
    doc: Don't do five prime trimming.
    inputBinding:
      position: 4
      prefix: -x
  - id: trunc_n
    type:
      - 'null'
      - boolean
    doc: Truncate sequences at position of first N.
    inputBinding:
      position: 4
      prefix: -n
  - id: gzip_output
    type:
      - 'null'
      - boolean
    doc: Output gzipped files.
    inputBinding:
      position: 4
      prefix: -g
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't print out any trimming information
    inputBinding:
      position: 4
      prefix: --quiet
outputs:
  - id: trimmed_output
    type: File
    doc: Output trimmed fastq file
    outputBinding:
      glob: $(inputs.output_file)
  - id: stdout
    type: stdout
    doc: Trimming summary
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sickle:v1.33-1b1-deb_cv1
stdout: sickle_se.out
