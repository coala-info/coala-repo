cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngsderive instrument
label: ngsderive_instrument
doc: "Process Next-generation sequencing files (BAM or FASTQ) to derive instrument
  information.\n\nTool homepage: https://github.com/claymcleod/ngsderive"
inputs:
  - id: ngsfiles
    type:
      type: array
      items: File
    doc: Next-generation sequencing files to process (BAM or FASTQ).
    inputBinding:
      position: 1
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable DEBUG log level.
    default: false
    inputBinding:
      position: 102
      prefix: --debug
  - id: n_reads
    type:
      - 'null'
      - int
    doc: How many reads to analyze from the start of the file. Any n < 1 to 
      parse whole file.
    default: 10000
    inputBinding:
      position: 102
      prefix: --n-reads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable INFO log level.
    default: false
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Write to filename rather than standard out.
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngsderive:4.0.0--pyhdfd78af_0
