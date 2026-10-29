cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - read_utils.py
  - dup_remove_mvicuna
label: viral-ngs_read_utils_dup_remove_mvicuna
doc: "Run mvicuna's duplicate removal operation on paired-end reads.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: in_fastq1
    type: File
    doc: "Input fastq file; 1st end of paired-end reads."
    inputBinding:
      position: 1
  - id: in_fastq2
    type: File
    doc: "Input fastq file; 2nd end of paired-end reads."
    inputBinding:
      position: 2
  - id: paired_out_fastq1
    type: string
    doc: "Output fastq file; 1st end of paired-end reads."
    inputBinding:
      position: 3
  - id: paired_out_fastq2
    type: string
    doc: "Output fastq file; 2nd end of paired-end reads."
    inputBinding:
      position: 4
  - id: unpaired_out_fastq
    type:
      - 'null'
      - string
    doc: "File name of output unpaired reads"
    inputBinding:
      position: 20
      prefix: --unpairedOutFastq
  - id: loglevel
    type:
      - 'null'
      - type: enum
        symbols:
          - DEBUG
          - INFO
          - WARNING
          - ERROR
          - CRITICAL
          - EXCEPTION
    doc: "Verboseness of output. [default: DEBUG]"
    inputBinding:
      position: 20
      prefix: --loglevel
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: "Base directory for temp files. [default: /tmp]"
    inputBinding:
      position: 20
      prefix: --tmp_dir
  - id: tmp_dir_keep
    type:
      - 'null'
      - boolean
    doc: "Keep the tmp_dir if an exception occurs while running. Default is to delete all temp files at the end, even if there's a failure."
    inputBinding:
      position: 20
      prefix: --tmp_dirKeep
outputs:
  - id: paired_out_fastq1_file
    type: File
    doc: "Output file written to paired_out_fastq1"
    outputBinding:
      glob: $(inputs.paired_out_fastq1)
  - id: paired_out_fastq2_file
    type: File
    doc: "Output file written to paired_out_fastq2"
    outputBinding:
      glob: $(inputs.paired_out_fastq2)
  - id: unpaired_out_fastq_file
    type:
      - 'null'
      - File
    doc: "Output file written to unpaired_out_fastq"
    outputBinding:
      glob: $(inputs.unpaired_out_fastq)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
