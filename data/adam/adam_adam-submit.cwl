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
    doc: Arguments passed to Spark (a "--" separator is added after them)
    inputBinding:
      position: 1
      valueFrom: '$(self === null ? null : self.concat(["--"]))'
  - id: command
    type: string
    doc: The ADAM command to execute (e.g., countKmers, transformAlignments, 
      adam2fastq, etc.)
    inputBinding:
      position: 2
  - id: input_file
    type:
      - 'null'
      - File
    doc: INPUT file of the ADAM command (SAM/BAM/FASTA/VCF/...)
    inputBinding:
      position: 3
  - id: output_path
    type:
      - 'null'
      - string
    doc: OUTPUT location of the ADAM command
    inputBinding:
      position: 4
  - id: adam_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Other arguments and options of the chosen ADAM command
    inputBinding:
      position: 5
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output
    type:
      - 'null'
      - File
      - Directory
    doc: OUTPUT written by the ADAM command (a Parquet directory or a file)
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: SPARK_LOCAL_IP
        envValue: 127.0.0.1
      - envName: SPARK_LOCAL_HOSTNAME
        envValue: localhost
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/adam:1.0.1--hdfd78af_0
stdout: adam_adam-submit.out
