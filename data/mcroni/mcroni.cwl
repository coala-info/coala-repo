cwlVersion: v1.2
class: CommandLineTool
baseCommand: mcroni
label: mcroni
doc: "Analyse the local genomic context of mcr-1.\n\nTool homepage: https://github.com/liampshaw/mcroni"
inputs:
  - id: append
    type:
      - 'null'
      - boolean
    doc: Append to existing output files.
    inputBinding:
      position: 101
      prefix: --append
  - id: fasta
    type:
      - 'null'
      - File
    doc: Fasta file
    inputBinding:
      position: 101
      prefix: --fasta
  - id: filelist
    type:
      - 'null'
      - File
    doc: 'Alternatively: a list of fasta files'
    inputBinding:
      position: 101
      prefix: --filelist
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwriting of output files.
    inputBinding:
      position: 101
      prefix: --force
  - id: output
    type: string
    doc: Output prefix
    inputBinding:
      position: 101
      prefix: --output
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mcroni:1.0.4--pyh5e36f6f_0
stdout: mcroni.out
