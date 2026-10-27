cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - read_utils.py
  - sort_bam
label: viral-ngs_read_utils_sort_bam
doc: "Sort BAM file\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: in_bam
    type: File
    doc: "Input bam file."
    inputBinding:
      position: 1
  - id: out_bam
    type: string
    doc: "Output bam file, sorted."
    inputBinding:
      position: 2
  - id: sort_order
    type:
      type: enum
      symbols:
        - unsorted
        - queryname
        - coordinate
    default: coordinate
    doc: "How to sort the reads. [default: coordinate]"
    inputBinding:
      position: 3
  - id: index
    type:
      - 'null'
      - boolean
    doc: "Index outBam (default: False)"
    inputBinding:
      position: 20
      prefix: --index
  - id: md5
    type:
      - 'null'
      - boolean
    doc: "MD5 checksum outBam (default: False)"
    inputBinding:
      position: 20
      prefix: --md5
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
    doc: "Optional arguments to Picard's SortSam, OPTIONNAME=value ..."
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
    doc: "Sorted bam file"
    outputBinding:
      glob: $(inputs.out_bam)
  - id: out_index
    type:
      - 'null'
      - File
    doc: Index of the sorted bam (with --index)
    outputBinding:
      glob: ['$(inputs.out_bam).bai', '$(inputs.out_bam.replace(/\.bam$/, ".bai"))']
  - id: out_md5
    type:
      - 'null'
      - File
    doc: "MD5 checksum (with --md5)"
    outputBinding:
      glob: $(inputs.out_bam).md5
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_read_utils_sort_bam.out
