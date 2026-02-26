cwlVersion: v1.2
class: CommandLineTool
baseCommand: cutqc.sh
label: cutqc_cutqc
doc: "Performs quality control on sequencing reads, optionally with adapter trimming.\n\
  \nTool homepage: https://github.com/obenno/cutqc"
inputs:
  - id: subcommand
    type: string
    doc: "The subcommand to run: 'cutqc' or 'qc_only'."
    inputBinding:
      position: 1
  - id: in_read1
    type: File
    doc: Input read 1 FASTQ file (gzipped).
    inputBinding:
      position: 2
  - id: input_fastq
    type: File
    doc: Input FASTQ file (gzipped) for qc_only subcommand.
    inputBinding:
      position: 3
  - id: in_read2
    type:
      - 'null'
      - File
    doc: Input read 2 FASTQ file (gzipped).
    inputBinding:
      position: 4
  - id: cutadapt_option
    type:
      - 'null'
      - type: array
        items: string
    doc: Options to be passed to cutadapt. Refer to cutadapt manual for details.
    inputBinding:
      position: 105
outputs:
  - id: out_report
    type: File
    doc: Output report file (HTML).
    outputBinding:
      glob: '*.out'
  - id: output_report
    type:
      - 'null'
      - File
    doc: Output report file (HTML) for qc_only subcommand.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cutqc:0.07--hdfd78af_0
