cwlVersion: v1.2
class: CommandLineTool
baseCommand: trust-barcoderep.pl
label: trust4_trust-barcoderep
doc: "Summarize the CDR3 file of barcoded (single-cell) TRUST4 data into a barcode report table (standard output).\n\nTool homepage: https://github.com/liulab-dfci/TRUST4"
inputs:
  - id: cdr3_file
    type: File
    doc: "xxx_cdr3.out file written by the TRUST4 annotator"
    inputBinding:
      position: 1
  - id: annot_file
    type:
      - 'null'
      - File
    doc: "xxx_annot.fa: TRUST4 annotation file (default: not used)"
    inputBinding:
      position: 101
      prefix: -a
  - id: no_imputation
    type:
      - 'null'
      - boolean
    doc: "do not perform imputation for partial CDR3 (default: impute)"
    inputBinding:
      position: 101
      prefix: --noImputation
  - id: impute_bcr
    type:
      - 'null'
      - boolean
    doc: "perform imputation for BCR partial CDR3 (default: no)"
    inputBinding:
      position: 101
      prefix: --imputeBCR
  - id: report_partial
    type:
      - 'null'
      - boolean
    doc: "include partial CDR3 in report (default: no partial)"
    inputBinding:
      position: 101
      prefix: --reportPartial
  - id: chains_in_barcode
    type:
      - 'null'
      - int
    doc: "number of chains in a barcode (default: 2)"
    inputBinding:
      position: 101
      prefix: --chainsInBarcode
outputs:
  - id: barcode_report
    type: stdout
    doc: "Barcode report table (standard output)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trust4:1.1.8--h5ca1c30_0
stdout: trust_barcode_report.tsv
