cwlVersion: v1.2
class: CommandLineTool
baseCommand: autometa-hmmsearch-filter
label: autometa_autometa-hmmsearch-filter
doc: "Filters domtblout generated from hmmsearch using provided cutoffs\n\nTool homepage: https://github.com/KwanLab/Autometa"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: domtblout
    type: File
    doc: "Path to domtblout generated from hmmsearch -domtblout <domtblout> ... <hmmfile> <seqdb>"
    inputBinding:
      position: 1
      prefix: --domtblout
  - id: cutoffs
    type: File
    doc: "Path to cutoffs corresponding to hmmfile used with hmmsearch <hmmfile> <seqdb>"
    inputBinding:
      position: 1
      prefix: --cutoffs
  - id: seqdb
    type: File
    doc: "Path to orfs seqdb used as input to hmmsearch ... <hmmfile> <seqdb>"
    inputBinding:
      position: 1
      prefix: --seqdb
  - id: out
    type: string
    doc: "Path to write table of markers passing provided cutoffs"
    inputBinding:
      position: 1
      prefix: --out
outputs:
  - id: markers_out
    type: File
    doc: "Table of markers passing cutoffs"
    outputBinding:
      glob: "$(inputs.out)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
