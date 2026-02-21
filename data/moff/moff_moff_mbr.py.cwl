cwlVersion: v1.2
class: CommandLineTool
baseCommand: moff_moff_mbr.py
label: moff_moff_mbr.py
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log regarding container image conversion and disk space issues.\n
  \nTool homepage: https://github.com/compomics/moFF"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moff:2.0.3--py36_2
stdout: moff_moff_mbr.py.out
