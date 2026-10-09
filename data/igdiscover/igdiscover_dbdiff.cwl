cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - igdiscover
  - dbdiff
label: igdiscover_dbdiff
doc: "Compare two FASTA files based on sequences. The order of records does not matter. Exit code 1 means there are lost or gained records or sequence differences.\n\nTool homepage: https://igdiscover.se/"
inputs:
  - id: a
    type: File
    doc: "FASTA file with expected sequences"
    inputBinding:
      position: 1
  - id: b
    type: File
    doc: "FASTA file with actual sequences"
    inputBinding:
      position: 2
  - id: color
    type: ['null', string]
    doc: "Whether to colorize output: auto, never or always"
    inputBinding:
      position: 3
      prefix: --color
outputs:
  - id: stdout
    type: stdout
    doc: "Differences between the two files"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igdiscover:0.15.1--pyhdfd78af_2
stdout: igdiscover_dbdiff.out
successCodes: [0, 1]
