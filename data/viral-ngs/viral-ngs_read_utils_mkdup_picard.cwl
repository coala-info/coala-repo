cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - read_utils.py
  - mkdup_picard
label: viral-ngs_read_utils_mkdup_picard
doc: "Mark or remove duplicate reads from BAM file.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: in_bams
    type:
      type: array
      items: File
    doc: "Input reads, BAM format."
    inputBinding:
      position: 1
  - id: out_bam
    type: string
    doc: "Output reads, BAM format."
    inputBinding:
      position: 2
  - id: out_metrics
    type:
      - 'null'
      - string
    doc: "Output metrics file. Default is to dump to a temp file."
    inputBinding:
      position: 20
      prefix: --outMetrics
  - id: remove
    type:
      - 'null'
      - boolean
    doc: "Instead of marking duplicates, remove them entirely (default: False)"
    inputBinding:
      position: 20
      prefix: --remove
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
    doc: "Optional arguments to Picard's MarkDuplicates, OPTIONNAME=value ..."
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
  - id: out_metrics_file
    type:
      - 'null'
      - File
    doc: "Duplication metrics"
    outputBinding:
      glob: $(inputs.out_metrics)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_read_utils_mkdup_picard.out
