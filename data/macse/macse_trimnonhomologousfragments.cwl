cwlVersion: v1.2
class: CommandLineTool
baseCommand: macse
label: macse_trimnonhomologousfragments
doc: "identifies (and trims) sequence fragments that do not share homology with other
  sequences and remove those fragments.\n\nTool homepage: https://bioweb.supagro.inra.fr/macse/"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debug mode
    inputBinding:
      position: 101
      prefix: -debug
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macse:2.07--hdfd78af_0
stdout: macse_trimnonhomologousfragments.out
