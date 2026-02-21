cwlVersion: v1.2
class: CommandLineTool
baseCommand: pstrain_merge.py
label: pstrain_merge.py
doc: "The provided text does not contain help information or a description for the
  tool; it appears to be a container execution error log.\n\nTool homepage: https://github.com/wshuai294/PStrain"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pstrain:1.0.3--h9ee0642_0
stdout: pstrain_merge.py.out
