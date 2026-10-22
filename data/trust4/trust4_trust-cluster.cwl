cwlVersion: v1.2
class: CommandLineTool
baseCommand: trust-cluster.py
label: trust4_trust-cluster
doc: "Re-cluster the CDR3 regions of a TRUST4 CDR3 file (or report) by sequence similarity. The result goes to standard output.\n\nTool homepage: https://github.com/liulab-dfci/TRUST4"
inputs:
  - id: cdr3_file
    type: File
    doc: "trust_cdr3.out file (or the simplerep report with --format simplerep)"
    inputBinding:
      position: 1
  - id: similarity
    type:
      - 'null'
      - float
    doc: "similarity of two CDR3s (default: 0.8)"
    inputBinding:
      position: 101
      prefix: -s
  - id: prefix
    type:
      - 'null'
      - string
    doc: "prefix to new cluster name (default: cluster)"
    inputBinding:
      position: 101
      prefix: --prefix
  - id: center
    type:
      - 'null'
      - boolean
    doc: "use the center of the cluster for similarity comparison (default: no)"
    inputBinding:
      position: 101
      prefix: --center
  - id: representative
    type:
      - 'null'
      - boolean
    doc: "use representative CDR3 from each contig for cluster (default: no)"
    inputBinding:
      position: 101
      prefix: --representative
  - id: format
    type:
      - 'null'
      - string
    doc: "the input format type: cdr3 or simplerep (default: cdr3)"
    inputBinding:
      position: 101
      prefix: --format
outputs:
  - id: clusters
    type: stdout
    doc: "Clustered CDR3 table (standard output)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trust4:1.1.8--h5ca1c30_0
stdout: trust_cluster.out
