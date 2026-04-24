cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngsderive encoding
label: ngsderive_encoding
doc: "Encodes sequencing files.\n\nTool homepage: https://github.com/claymcleod/ngsderive"
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
    inputBinding:
      position: 102
      prefix: --debug
  - id: n_reads
    type:
      - 'null'
      - int
    doc: How many reads to analyze from the start of the file. Any n < 1 to 
      parse whole file.
    inputBinding:
      position: 102
      prefix: --n-reads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable INFO log level.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write to filename rather than standard out.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngsderive:4.0.0--pyhdfd78af_0
