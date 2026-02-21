cwlVersion: v1.2
class: CommandLineTool
baseCommand: macse
label: macse
doc: "Multiple Alignment of Coding SEquences\n\nTool homepage: https://bioweb.supagro.inra.fr/macse/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macse:2.07--hdfd78af_0
stdout: macse.out
