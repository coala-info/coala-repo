cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - read_utils.py
  - fastq_to_bam
label: viral-ngs_read_utils_fastq_to_bam
doc: "Convert a pair of fastq paired-end read files and optional text header to a single bam file.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
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
  - id: out_bam
    type: string
    doc: "Output bam file."
    inputBinding:
      position: 3
  - id: sample_name
    type:
      - 'null'
      - string
    doc: "Sample name to insert into the read group header (one of sample_name or header is required)."
    inputBinding:
      position: 20
      prefix: --sampleName
  - id: header
    type:
      - 'null'
      - File
    doc: "Optional text file containing header (one of sample_name or header is required)."
    inputBinding:
      position: 20
      prefix: --header
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
    doc: "Optional arguments to Picard's FastqToSam, OPTIONNAME=value ..."
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
  - id: out_bam_file
    type: File
    doc: "Output bam file"
    outputBinding:
      glob: $(inputs.out_bam)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_read_utils_fastq_to_bam.out
