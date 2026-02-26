cwlVersion: v1.2
class: CommandLineTool
baseCommand: fba_filter
label: fba_filter
doc: "Filter extracted cell and feature barcodes (output of `extract` or `qc`). Additional
  fragment filter/selection can be applied through `-cb_seq` and/or `-fb_seq`.\n\n\
  Tool homepage: https://github.com/jlduan/fba"
inputs:
  - id: cb_extra_seq
    type:
      - 'null'
      - string
    doc: specify an extra constant sequence to filter on read 1. Default (None)
    default: None
    inputBinding:
      position: 101
      prefix: --cb_extra_seq
  - id: cb_extra_seq_mismatches
    type:
      - 'null'
      - string
    doc: specify the maximun edit distance allowed for the extra constant 
      sequence on read 1 for filtering. Default (None)
    default: None
    inputBinding:
      position: 101
      prefix: --cb_extra_seq_mismatches
  - id: cb_left_shift
    type:
      - 'null'
      - int
    doc: specify the maximum left shift allowed for cell barcode. Default (1)
    default: 1
    inputBinding:
      position: 101
      prefix: --cb_left_shift
  - id: cb_mismatches
    type:
      - 'null'
      - int
    doc: specify cell barcode mismatching threshold. Default (1)
    default: 1
    inputBinding:
      position: 101
      prefix: --cb_mismatches
  - id: cb_right_shift
    type:
      - 'null'
      - int
    doc: specify the maximum right shift allowed for cell barcode. Default (1)
    default: 1
    inputBinding:
      position: 101
      prefix: --cb_right_shift
  - id: cb_start
    type:
      - 'null'
      - int
    doc: specify expected cell barcode starting postion on read 1. Default (0)
    default: 0
    inputBinding:
      position: 101
      prefix: --cb_start
  - id: fb_extra_seq
    type:
      - 'null'
      - string
    doc: specify an extra constant sequence to filter on read 2. Default (None)
    default: None
    inputBinding:
      position: 101
      prefix: --fb_extra_seq
  - id: fb_extra_seq_mismatches
    type:
      - 'null'
      - string
    doc: specify the maximun edit distance allowed for the extra constant 
      sequence on read 2. Default (None)
    default: None
    inputBinding:
      position: 101
      prefix: --fb_extra_seq_mismatches
  - id: fb_left_shift
    type:
      - 'null'
      - int
    doc: specify the maximum left shift allowed for feature barcode. Default (1)
    default: 1
    inputBinding:
      position: 101
      prefix: --fb_left_shift
  - id: fb_mismatches
    type:
      - 'null'
      - int
    doc: specify feature barcode mismatching threshold. Default (1)
    default: 1
    inputBinding:
      position: 101
      prefix: --fb_mismatches
  - id: fb_right_shift
    type:
      - 'null'
      - int
    doc: specify the maximum right shift allowed for feature barcode. Default 
      (1)
    default: 1
    inputBinding:
      position: 101
      prefix: --fb_right_shift
  - id: fb_start
    type:
      - 'null'
      - int
    doc: specify expected feature barcode starting postion on read 2. Default 
      (10)
    default: 10
    inputBinding:
      position: 101
      prefix: --fb_start
  - id: input
    type: File
    doc: specify an input file. The output of `extract` or `qc`
    inputBinding:
      position: 101
      prefix: --input
outputs:
  - id: output
    type: File
    doc: specify an output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fba:0.0.13--pyhdfd78af_0
