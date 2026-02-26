cwlVersion: v1.2
class: CommandLineTool
baseCommand: macse
label: macse_trimsequences
doc: "removes the 3' and 5' parts of the input sequence that are non homologous to
  an alignment....\n\nTool homepage: https://bioweb.supagro.inra.fr/macse/"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debug mode
    inputBinding:
      position: 101
      prefix: -debug
  - id: program_name
    type:
      - 'null'
      - string
    doc: Specify the program to run
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
stdout: macse_trimsequences.out
