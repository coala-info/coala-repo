cwlVersion: v1.2
class: CommandLineTool
baseCommand: Popera.py
label: popera_Popera.py
doc: "Popera (Processing of Pooled CRISPR screens) is a tool for analyzing CRISPR-Cas9
  screens.\n\nTool homepage: https://github.com/forrestzhang/Popera"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popera:1.0.3--py_0
stdout: popera_Popera.py.out
