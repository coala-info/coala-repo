cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - read_utils.py
  - filter_bam
label: viral-ngs_read_utils_filter_bam
doc: "Filter BAM file by read name\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: in_bam
    type: File
    doc: "Input bam file."
    inputBinding:
      position: 1
  - id: read_list
    type: File
    doc: "Input file of read IDs."
    inputBinding:
      position: 2
  - id: out_bam
    type: string
    doc: "Output bam file."
    inputBinding:
      position: 3
  - id: exclude
    type:
      - 'null'
      - boolean
    doc: "If specified, readList is a list of reads to remove from input. Default behavior is to treat readList as an inclusion list (all unnamed reads are removed)."
    inputBinding:
      position: 20
      prefix: --exclude
  - id: jvm_memory
    type:
      - 'null'
      - string
    doc: "JVM virtual memory size (default: 4g)"
    inputBinding:
      position: 20
      prefix: --JVMmemory
  - id: picard_options
    type:
      - 'null'
      - type: array
        items: string
    doc: "Optional arguments to Picard's FilterSamReads, OPTIONNAME=value ..."
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
    doc: "Filtered bam file"
    outputBinding:
      glob: $(inputs.out_bam)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_read_utils_filter_bam.out
