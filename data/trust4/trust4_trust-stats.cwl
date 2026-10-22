cwlVersion: v1.2
class: CommandLineTool
baseCommand: trust-stats.py
label: trust4_trust-stats
doc: "Compute immune repertoire diversity statistics from a TRUST4 report. The statistics go to standard output.\n\nTool homepage: https://github.com/liulab-dfci/TRUST4"
inputs:
  - id: repfile
    type: File
    doc: "repertoire file"
    inputBinding:
      position: 101
      prefix: -r
  - id: format
    type:
      - 'null'
      - string
    doc: "repertoire file format (TRUST4_report, TRUST4_barcode_report, ...). Default: TRUST4_report"
    inputBinding:
      position: 101
      prefix: -f
  - id: ntaa
    type:
      - 'null'
      - string
    doc: "use nucleotide (nt) or amino acids (aa). Default: aa"
    inputBinding:
      position: 101
      prefix: --ntaa
outputs:
  - id: stats
    type: stdout
    doc: "Diversity statistics (standard output)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trust4:1.1.8--h5ca1c30_0
stdout: trust_stats.out
