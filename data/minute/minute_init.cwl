cwlVersion: v1.2
class: CommandLineTool
baseCommand: minute init
label: minute_init
doc: "Create and initialize a new pipeline directory\n\nTool homepage: https://github.com/NBISweden/minute/"
inputs:
  - id: directory
    type: Directory
    doc: New pipeline directory to create
    inputBinding:
      position: 1
  - id: barcodes
    type:
      - 'null'
      - File
    doc: Barcodes description file.
    inputBinding:
      position: 102
      prefix: --barcodes
  - id: config
    type:
      - 'null'
      - File
    doc: Optional minute.yaml file to use as configuration. If not provided, a 
      template will be created.
    inputBinding:
      position: 102
      prefix: --config
  - id: input
    type:
      - 'null'
      - string
    doc: Name of the input sample (FASTQ name without _R1/_R2).
    inputBinding:
      position: 102
      prefix: --input
  - id: reads
    type:
      - 'null'
      - Directory
    doc: Raw reads directory with paired-end FASTQ files.
    inputBinding:
      position: 102
      prefix: --reads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minute:0.12.1--pyhdfd78af_1
stdout: minute_init.out
