cwlVersion: v1.2
class: CommandLineTool
baseCommand: fba_extract
label: fba_extract
doc: "Extract cell and feature barcodes from paired fastq files. For single cell assays,
  read 1 usually contains cell partitioning and UMI information, and read 2 contains
  feature information.\n\nTool homepage: https://github.com/jlduan/fba"
inputs:
  - id: cb_num_n_threshold
    type:
      - 'null'
      - int
    doc: specify maximum number of ambiguous nucleotides allowed for read 1. 
      Default (3)
    default: 3
    inputBinding:
      position: 101
      prefix: --cb_num_n_threshold
  - id: cell_barcode_mismatches
    type:
      - 'null'
      - int
    doc: specify cell barcode mismatching threshold. Default (1)
    default: 1
    inputBinding:
      position: 101
      prefix: --cb_mismatches
  - id: cell_barcode_reverse_complement
    type:
      - 'null'
      - boolean
    doc: specify to convert cell barcode sequences into their reverse-complement
      counterparts for processing.
    inputBinding:
      position: 101
      prefix: --cell_barcode_reverse_complement
  - id: fb_num_n_threshold
    type:
      - 'null'
      - int
    doc: specify maximum number of ambiguous nucleotides allowed for read 2. 
      Default (3)
    default: 3
    inputBinding:
      position: 101
      prefix: --fb_num_n_threshold
  - id: feature_barcode_mismatches
    type:
      - 'null'
      - int
    doc: specify feature barcode mismatching threshold. Default (1)
    default: 1
    inputBinding:
      position: 101
      prefix: --fb_mismatches
  - id: feature_ref
    type: File
    doc: specify a reference of feature barcodes
    inputBinding:
      position: 101
      prefix: --feature_ref
  - id: read1
    type: File
    doc: specify fastq file for read 1
    inputBinding:
      position: 101
      prefix: --read1
  - id: read1_coordinate
    type:
      - 'null'
      - string
    doc: "specify coordinate 'start,end' of read 1 to search. For example, '0,16':
      starts at 0, stops at 15. Nucleotide bases outside the range will be masked
      as lowercase in the output. Default (0,16)"
    default: 0,16
    inputBinding:
      position: 101
      prefix: --read1_coordinate
  - id: read2
    type: File
    doc: specify fastq file for read 2
    inputBinding:
      position: 101
      prefix: --read2
  - id: read2_coordinate
    type:
      - 'null'
      - string
    doc: see '-r1_c/--read1_coordinate'
    inputBinding:
      position: 101
      prefix: --read2_coordinate
  - id: whitelist
    type: File
    doc: specify a whitelist of accepted cell barcodes
    inputBinding:
      position: 101
      prefix: --whitelist
outputs:
  - id: output
    type: File
    doc: specify an output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fba:0.0.13--pyhdfd78af_0
