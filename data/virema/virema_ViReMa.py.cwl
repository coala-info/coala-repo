cwlVersion: v1.2
class: CommandLineTool
baseCommand: ViReMa.py
label: virema_ViReMa.py
doc: "Viral Recombination Mapper (ViReMa) for detecting recombination events in NGS
  data.\n\nTool homepage: https://sourceforge.net/projects/virema/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virema:0.6--py27_0
stdout: virema_ViReMa.py.out
