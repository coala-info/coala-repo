cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - read_utils.py
  - bam_to_fastq
label: viral-ngs_read_utils_bam_to_fastq
doc: "Convert a bam file to a pair of fastq paired-end read files and optional text header.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: in_bam
    type: File
    doc: "Input bam file."
    inputBinding:
      position: 1
  - id: out_fastq1
    type: string
    doc: "Output fastq file; 1st end of paired-end reads."
    inputBinding:
      position: 2
  - id: out_fastq2
    type: string
    doc: "Output fastq file; 2nd end of paired-end reads."
    inputBinding:
      position: 3
  - id: out_header
    type:
      - 'null'
      - string
    doc: "Optional text file name that will receive bam header."
    inputBinding:
      position: 20
      prefix: --outHeader
  - id: jvm_memory
    type:
      - 'null'
      - string
    doc: "JVM virtual memory size (default: 2g)"
    inputBinding:
      position: 20
      prefix: --JVMmemory
  - id: picard_options
    type:
      - 'null'
      - type: array
        items: string
    doc: "Optional arguments to Picard's SamToFastq, OPTIONNAME=value ..."
    inputBinding:
      position: 30
      prefix: --picardOptions
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
  - id: out_header_file
    type:
      - 'null'
      - File
    doc: "Bam header text"
    outputBinding:
      glob: $(inputs.out_header)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_read_utils_bam_to_fastq.out
