cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - read_utils.py
  - purge_unmated
label: viral-ngs_read_utils_purge_unmated
doc: "Use mergeShuffledFastqSeqs to purge unmated reads, and put corresponding reads in the same order. Corresponding sequences must have sequence identifiers of the form SEQID/1 and SEQID/2.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
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
  - id: regex
    type:
      - 'null'
      - string
    doc: "Perl regular expression to parse paired read IDs (default: ^@(\\S+)/[1|2]$)"
    inputBinding:
      position: 20
      prefix: --regex
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
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_read_utils_purge_unmated.out
