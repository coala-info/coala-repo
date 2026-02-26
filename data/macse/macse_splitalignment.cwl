cwlVersion: v1.2
class: CommandLineTool
baseCommand: macse
label: macse_splitalignment
doc: "splits one alignment, to extract a subset of sequences and/or sites.\n\nTool
  homepage: https://bioweb.supagro.inra.fr/macse/"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debug mode.
    inputBinding:
      position: 101
      prefix: -debug
  - id: prog
    type:
      - 'null'
      - string
    doc: Specify the MACSE program to run. Default is 'alignSequences'.
    inputBinding:
      position: 101
      prefix: -prog
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macse:2.07--hdfd78af_0
stdout: macse_splitalignment.out
