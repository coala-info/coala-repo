cwlVersion: v1.2
class: CommandLineTool
baseCommand: hmmpress
label: hmmer_hmmpress
doc: "prepare an HMM database for faster hmmscan searches\n\nTool homepage: http://hmmer.org/"
inputs:
  - id: hmmfile
    type: File
    doc: HMM database file to be pressed
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: 'force: overwrite any previous pressed files'
    inputBinding:
      position: 102
      prefix: -f
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmmer:3.4--hb6cb901_4
stdout: hmmer_hmmpress.out
