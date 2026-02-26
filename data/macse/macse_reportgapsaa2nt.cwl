cwlVersion: v1.2
class: CommandLineTool
baseCommand: macse
label: macse_reportgapsaa2nt
doc: "uses a amino acid alignment to align nucleotide sequences....\n\nTool homepage:
  https://bioweb.supagro.inra.fr/macse/"
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
    doc: Specify the MACSE program to run
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
stdout: macse_reportgapsaa2nt.out
