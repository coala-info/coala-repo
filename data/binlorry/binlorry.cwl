cwlVersion: v1.2
class: CommandLineTool
baseCommand: binlorry
label: binlorry
doc: "BinLorry: a tool for binning sequencing reads into files based on header information
  or read properties.\n\nTool homepage: https://github.com/rambaut/binlorry"
inputs:
  - id: bin_by
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify header field(s) to bin the reads by. For multiple fields these 
      will be nested in order specified. e.g. `--bin-by barcode reference`
    inputBinding:
      position: 101
      prefix: --bin-by
  - id: csv_file
    type:
      - 'null'
      - File
    doc: A CSV file with metadata fields for reads or a directory of csv files 
      that will be recursively searched for names corresponding to a matching 
      input FASTA/FASTQ files.
    inputBinding:
      position: 101
      prefix: --data
  - id: filter_by
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify header field and accepted values to filter the reads by. 
      Multiple instances of this option can be specified. e.g. `--filter-by 
      barcode BC01 BC02--filter-by genotype Type1`
    inputBinding:
      position: 101
      prefix: --filter-by
  - id: force_output
    type:
      - 'null'
      - boolean
    doc: Output binned/filtered files even if empty.
    default: false
    inputBinding:
      position: 101
      prefix: --force-output
  - id: header_delimiters
    type:
      - 'null'
      - string
    doc: Delimiters to use when searching for key:value pairs in FASTA/FASTQ 
      header.
    default: '='
    inputBinding:
      position: 101
      prefix: --header-delimiters
  - id: input_path
    type: File
    doc: FASTA/FASTQ of input reads or a directory which will be recursively 
      searched for FASTQ files (required).
    inputBinding:
      position: 101
      prefix: --input
  - id: max_length
    type:
      - 'null'
      - int
    doc: Filter the reads by their length, specifying the maximum length.
    inputBinding:
      position: 101
      prefix: --max-length
  - id: min_length
    type:
      - 'null'
      - int
    doc: Filter the reads by their length, specifying the minimum length.
    inputBinding:
      position: 101
      prefix: --min-length
  - id: out_report
    type:
      - 'null'
      - boolean
    doc: Output a report along with FASTA/FASTQ.
    default: false
    inputBinding:
      position: 101
      prefix: --out-report
  - id: output
    type: string
    doc: Output filename (or filename prefix)
    inputBinding:
      position: 101
      prefix: --output
  - id: unordered_data
    type:
      - 'null'
      - boolean
    doc: The metadata tables are not in the same order as the reads - they will 
      all beloaded and then looked up as needed (slower).
    default: false
    inputBinding:
      position: 101
      prefix: --unordered_data
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Level of output information: 0 = none, 1 = some, 2 = lots'
    default: 1
    inputBinding:
      position: 101
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/binlorry:1.3.1--py_0
stdout: binlorry.out
