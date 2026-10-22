cwlVersion: v1.2
class: CommandLineTool
baseCommand: trust-simplerep.pl
label: trust4_trust-simplerep
doc: "Summarize the CDR3 file (xxx_cdr3.out) of TRUST4 into a repertoire report table (standard output).\n\nTool homepage: https://github.com/liulab-dfci/TRUST4"
inputs:
  - id: cdr3_file
    type: File
    doc: "xxx_cdr3.out file written by the TRUST4 annotator"
    inputBinding:
      position: 1
  - id: decimal_cnt
    type:
      - 'null'
      - boolean
    doc: "the count column uses decimal instead of truncated integer (default: not used)"
    inputBinding:
      position: 101
      prefix: --decimalCnt
  - id: barcode_cnt
    type:
      - 'null'
      - boolean
    doc: "the count column is the number of barcode instead of read support (default: not used)"
    inputBinding:
      position: 101
      prefix: --barcodeCnt
  - id: junction
    type:
      - 'null'
      - File
    doc: "trust_annot.fa: output junction information for the CDR3 (default: not used)"
    inputBinding:
      position: 101
      prefix: --junction
  - id: report_partial
    type:
      - 'null'
      - boolean
    doc: "include partial CDR3 in report (default: no partial)"
    inputBinding:
      position: 101
      prefix: --reportPartial
  - id: filter_barcoderep
    type:
      - 'null'
      - File
    doc: "only summarize primary CDR3s in the barcode report file (default: not used)"
    inputBinding:
      position: 101
      prefix: --filterBarcoderep
  - id: filter_barcoderep_read_cnt
    type:
      - 'null'
      - float
    doc: "filter primary CDR3s in the barcode report less than this read count (default: 0)"
    inputBinding:
      position: 101
      prefix: --filterBarcoderepReadCnt
  - id: filter_tcr_error
    type:
      - 'null'
      - float
    doc: "filter TCR CDR3s less than the fraction of representative CDR3 in the consensus (default: 0.05)"
    inputBinding:
      position: 101
      prefix: --filterTcrError
  - id: filter_bcr_error
    type:
      - 'null'
      - float
    doc: "filter BCR CDR3s less than the fraction of representative CDR3 in the consensus (default: 0)"
    inputBinding:
      position: 101
      prefix: --filterBcrError
outputs:
  - id: report
    type: stdout
    doc: "Repertoire report table (standard output)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trust4:1.1.8--h5ca1c30_0
stdout: trust_report.tsv
