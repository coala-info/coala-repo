cwlVersion: v1.2
class: CommandLineTool
baseCommand: trust-airr.pl
label: trust4_trust-airr
doc: "Convert the TRUST4 report and annotation files into the AIRR format table (standard output).\n\nTool homepage: https://github.com/liulab-dfci/TRUST4"
inputs:
  - id: report_file
    type: File
    doc: "trust_report.tsv file"
    inputBinding:
      position: 1
  - id: annot_file
    type: File
    doc: "trust_annot.fa file"
    inputBinding:
      position: 2
  - id: format
    type:
      - 'null'
      - string
    doc: "simplerep, cdr3 or barcoderep of the report file"
    inputBinding:
      position: 101
      prefix: --format
  - id: airr_align
    type:
      - 'null'
      - File
    doc: "file of trust_airr_align.tsv"
    inputBinding:
      position: 101
      prefix: --airr-align
outputs:
  - id: airr
    type: stdout
    doc: "AIRR table (standard output)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trust4:1.1.8--h5ca1c30_0
stdout: trust_airr.tsv
