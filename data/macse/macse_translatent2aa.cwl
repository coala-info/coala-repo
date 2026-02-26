cwlVersion: v1.2
class: CommandLineTool
baseCommand: macse
label: macse_translatent2aa
doc: "MACSE: Multiple Alignment of Coding SEquences accounting for frameshifts and
  stop codons.\n\nTool homepage: https://bioweb.supagro.inra.fr/macse/"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debug mode.
    inputBinding:
      position: 101
      prefix: -debug
  - id: program
    type:
      - 'null'
      - string
    doc: Specifies the MACSE program to run.
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
stdout: macse_translatent2aa.out
