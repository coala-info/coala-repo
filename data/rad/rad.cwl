cwlVersion: v1.2
class: CommandLineTool
baseCommand: rad
label: rad
doc: "Parses FASTQ files to identify barcodes and their associated UMI and/or cell
  barcodes, and outputs various processed files.\n\nTool homepage: https://github.com/indianewok/rad"
inputs:
  - id: bc_split
    type:
      - 'null'
      - boolean
    doc: write reads into per-barcode FASTQ files
    inputBinding:
      position: 101
      prefix: --bc_split
  - id: custom_whitelist
    type:
      - 'null'
      - File
    doc: path to a single custom whitelist CSV (i.e, barcodes that you've 
      already found in short-read matched data)
    inputBinding:
      position: 101
      prefix: --custom_whitelist
  - id: fastq
    type: File
    doc: input FASTQ file
    inputBinding:
      position: 101
      prefix: --fastq
  - id: global_whitelist
    type:
      - 'null'
      - File
    doc: path to a single custom global whitelist (i.e, all barcodes that could 
      potentially appear in this dataset) CSV
    inputBinding:
      position: 101
      prefix: --global_whitelist
  - id: kit
    type:
      - 'null'
      - string
    doc: use this kit's default whitelist
    inputBinding:
      position: 101
      prefix: --kit
  - id: layout
    type: string
    doc: layout key (five_prime, three_prime, splitseq) or a custom path
    inputBinding:
      position: 101
      prefix: --layout
  - id: max_verbose
    type:
      - 'null'
      - boolean
    doc: max verbose level (debug only)
    inputBinding:
      position: 101
      prefix: --max_verbose
  - id: mutation
    type:
      - 'null'
      - string
    doc: mutation space of each barcode
    inputBinding:
      position: 101
      prefix: --mutation
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: output directory
    inputBinding:
      position: 101
      prefix: --dir
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: filename prefix
    inputBinding:
      position: 101
      prefix: --output
  - id: shift
    type:
      - 'null'
      - string
    doc: shift space of each barcode
    inputBinding:
      position: 101
      prefix: --shift
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose mode
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rad:0.6.0--h077b44d_0
stdout: rad.out
