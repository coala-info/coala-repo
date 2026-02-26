cwlVersion: v1.2
class: CommandLineTool
baseCommand: make-families.sh
label: dunovo_make-families.sh
doc: "Read raw duplex sequencing reads, extract their barcodes, and group them by
  barcode.\nInput fastq's can be gzipped.\n\nTool homepage: https://github.com/galaxyproject/dunovo"
inputs:
  - id: reads_1
    type: File
    doc: First input fastq file
    inputBinding:
      position: 1
  - id: reads_2
    type: File
    doc: Second input fastq file
    inputBinding:
      position: 2
  - id: invariant_len
    type:
      - 'null'
      - int
    doc: The length of the invariant (ligation) portion of each read.
    default: 5
    inputBinding:
      position: 103
      prefix: -i
  - id: sort_memory_param
    type:
      - 'null'
      - string
    doc: "The memory usage parameter to pass directly to the sort command's -S option.\n\
      \    Can be an absolute figure like 5G or a percentage. See man sort for details."
    inputBinding:
      position: 103
      prefix: -S
  - id: sort_temp_dir
    type:
      - 'null'
      - Directory
    doc: "The temporary file directory that sort should use.\n    Will be passed directly
      to the sort command's -T option."
    inputBinding:
      position: 103
      prefix: -T
  - id: tag_len
    type:
      - 'null'
      - int
    doc: The length of the barcode portion of each read.
    default: 12
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dunovo:3.0.2--h7b50bb2_4
stdout: dunovo_make-families.sh.out
