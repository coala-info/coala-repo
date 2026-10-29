cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - read_utils.py
  - rmdup_prinseq_fastq
label: viral-ngs_read_utils_rmdup_prinseq_fastq
doc: "Run prinseq-lite's duplicate removal operation on paired-end reads. Also removes reads with more than one N.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
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
  - id: out_fastq1
    type: string
    doc: "Output fastq file; 1st end of paired-end reads."
    inputBinding:
      position: 3
  - id: out_fastq2
    type: string
    doc: "Output fastq file; 2nd end of paired-end reads."
    inputBinding:
      position: 4
  - id: include_unmated
    type:
      - 'null'
      - boolean
    doc: "Include unmated reads in the main output fastq files (default: False)"
    inputBinding:
      position: 20
      prefix: --includeUnmated
  - id: unpaired_out_fastq1
    type:
      - 'null'
      - string
    doc: "File name of output unpaired reads from 1st end of paired-end reads (independent of --includeUnmated)"
    inputBinding:
      position: 20
      prefix: --unpairedOutFastq1
  - id: unpaired_out_fastq2
    type:
      - 'null'
      - string
    doc: "File name of output unpaired reads from 2nd end of paired-end reads (independent of --includeUnmated)"
    inputBinding:
      position: 20
      prefix: --unpairedOutFastq2
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
      position: 21
      prefix: --tmp_dir
  - id: tmp_dir_keep
    type:
      - 'null'
      - boolean
    doc: "Keep the tmp_dir if an exception occurs while running. Default is to delete all temp files at the end, even if there's a failure."
    inputBinding:
      position: 21
      prefix: --tmp_dirKeep
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out_fastq1_file
    type: File
    doc: "Output fastq, 1st end"
    outputBinding:
      glob: $(inputs.out_fastq1)
  - id: out_fastq2_file
    type: File
    doc: "Output fastq, 2nd end"
    outputBinding:
      glob: $(inputs.out_fastq2)
  - id: unpaired_out_fastq1_file
    type:
      - 'null'
      - File
    doc: "Unpaired reads, 1st end"
    outputBinding:
      glob: $(inputs.unpaired_out_fastq1)
  - id: unpaired_out_fastq2_file
    type:
      - 'null'
      - File
    doc: "Unpaired reads, 2nd end"
    outputBinding:
      glob: $(inputs.unpaired_out_fastq2)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_read_utils_rmdup_prinseq_fastq.out
