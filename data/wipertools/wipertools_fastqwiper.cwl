cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wipertools
  - fastqwiper
label: wipertools_fastqwiper
doc: "Wipes quality scores from a FASTQ file.\n\nTool homepage: https://github.com/mazzalab/fastqwiper"
inputs:
  - id: alphabet
    type:
      - 'null'
      - string
    doc: Allowed characters set in the SEQ line.
    default: ACGTN
    inputBinding:
      position: 101
      prefix: --alphabet
  - id: fastq_in
    type: File
    doc: FASTQ file to be wiped
    inputBinding:
      position: 101
      prefix: --fastq_in
  - id: log_frequency
    type:
      - 'null'
      - int
    doc: Number of reads you want to print a status message.
    default: 500000
    inputBinding:
      position: 101
      prefix: --log_frequency
  - id: report
    type:
      - 'null'
      - File
    doc: File name of the final quality report. Print on screen if not specified
    inputBinding:
      position: 101
      prefix: --report
outputs:
  - id: fastq_out
    type: File
    doc: Wiped FASTQ file
    outputBinding:
      glob: $(inputs.fastq_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wipertools:1.1.5--pyhdfd78af_0
