cwlVersion: v1.2
class: CommandLineTool
baseCommand: moff_moff_all.py
label: moff_moff_all.py
doc: "The provided text does not contain help or usage information; it consists of
  system logs and a fatal error regarding container image conversion and disk space.\n
  \nTool homepage: https://github.com/compomics/moFF"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moff:2.0.3--py36_2
stdout: moff_moff_all.py.out
