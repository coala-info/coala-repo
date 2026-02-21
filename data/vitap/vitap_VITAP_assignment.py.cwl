cwlVersion: v1.2
class: CommandLineTool
baseCommand: vitap_VITAP_assignment.py
label: vitap_VITAP_assignment.py
doc: "VITAP assignment tool\n\nTool homepage: https://github.com/DrKaiyangZheng/VITAP/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vitap:1.10--pyhdfd78af_0
stdout: vitap_VITAP_assignment.py.out
