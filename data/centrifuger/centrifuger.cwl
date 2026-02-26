cwlVersion: v1.2
class: CommandLineTool
baseCommand: centrifuger
label: centrifuger
doc: "Perform taxonomic classification of sequencing reads.\n\nTool homepage: https://github.com/mourisl/centrifuger"
inputs:
  - id: barcode_file
    type:
      - 'null'
      - string
    doc: path to the barcode file
    inputBinding:
      position: 101
      prefix: --barcode
  - id: barcode_translate
    type:
      - 'null'
      - string
    doc: path to the barcode translation file.
    inputBinding:
      position: 101
      prefix: --barcode-translate
  - id: barcode_whitelist
    type:
      - 'null'
      - string
    doc: path to the barcode whitelist file.
    inputBinding:
      position: 101
      prefix: --barcode-whitelist
  - id: classified_prefix
    type:
      - 'null'
      - string
    doc: output classified reads to files with the prefix of <str>
    inputBinding:
      position: 101
      prefix: --cl
  - id: expand_taxid
    type:
      - 'null'
      - boolean
    doc: output the tax IDs that are promoted to the final report tax ID
    inputBinding:
      position: 101
      prefix: --expand-taxid
  - id: hitk_factor
    type:
      - 'null'
      - int
    doc: resolve at most <int>*k entries for each hit [40; use 0 for no 
      restriction]
    default: 40
    inputBinding:
      position: 101
      prefix: --hitk-factor
  - id: index_prefix
    type: File
    doc: index prefix
    inputBinding:
      position: 101
      prefix: -x
  - id: interleaved_read
    type:
      - 'null'
      - File
    doc: interleaved read file
    inputBinding:
      position: 101
      prefix: -i
  - id: max_assignments
    type:
      - 'null'
      - int
    doc: report upto <int> distinct, primary assignments for each read pair
    default: 1
    inputBinding:
      position: 101
      prefix: -k
  - id: merge_readpair
    type:
      - 'null'
      - boolean
    doc: merge overlapped paired-end reads and trim adapters
    inputBinding:
      position: 101
      prefix: --merge-readpair
  - id: min_hitlen
    type:
      - 'null'
      - int
    doc: minimum length of partial hits
    inputBinding:
      position: 101
      prefix: --min-hitlen
  - id: read1
    type:
      - 'null'
      - File
    doc: paired-end read 1
    inputBinding:
      position: 101
      prefix: '-1'
  - id: read2
    type:
      - 'null'
      - File
    doc: paired-end read 2
    inputBinding:
      position: 101
      prefix: '-2'
  - id: read_format
    type:
      - 'null'
      - string
    doc: format for read, barcode and UMI files, e.g. 
      r1:0:-1,r2:0:-1,bc:0:15,um:16:-1 for paired-end files with barcode and UMI
    inputBinding:
      position: 101
      prefix: --read-format
  - id: sample_sheet
    type:
      - 'null'
      - File
    doc: 'list of sample files, each row: "read1 read2 barcode UMI output". Use dot(.)
      to represent no such file'
    inputBinding:
      position: 101
      prefix: --sample-sheet
  - id: single_end_read
    type:
      - 'null'
      - File
    doc: single-end read
    inputBinding:
      position: 101
      prefix: -u
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 1
    inputBinding:
      position: 101
      prefix: -t
  - id: umi_file
    type:
      - 'null'
      - string
    doc: path to the UMI file
    inputBinding:
      position: 101
      prefix: --UMI
  - id: unclassified_prefix
    type:
      - 'null'
      - string
    doc: output unclassified reads to files with the prefix of <str>
    inputBinding:
      position: 101
      prefix: --un
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/centrifuger:1.1.0--hf426362_0
stdout: centrifuger.out
