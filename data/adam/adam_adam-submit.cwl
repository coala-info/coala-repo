cwlVersion: v1.2
class: CommandLineTool
baseCommand: adam-submit
label: adam_adam-submit
doc: "ADAM is a genomics analysis platform which leverages Apache Spark. This tool
  provides various actions for transforming, converting, and analyzing genomic data.\n\
  \nTool homepage: https://github.com/bigdatagenomics/adam"
inputs:
  - id: spark_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments passed to Spark
    inputBinding:
      position: 1
  - id: command
    type: string
    doc: The ADAM command to execute (e.g., countKmers, transformAlignments, 
      adam2fastq, etc.)
    inputBinding:
      position: 2
  - id: adam_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments specific to the chosen ADAM command
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/adam:1.0.1--hdfd78af_0
stdout: adam_adam-submit.out
