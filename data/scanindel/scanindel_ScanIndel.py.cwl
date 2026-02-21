cwlVersion: v1.2
class: CommandLineTool
baseCommand: scanindel_ScanIndel.py
label: scanindel_ScanIndel.py
doc: "\nTool homepage: https://github.com/cauyrd/ScanIndel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scanindel:1.3--py27_0
stdout: scanindel_ScanIndel.py.out
