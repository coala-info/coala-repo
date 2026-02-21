cwlVersion: v1.2
class: CommandLineTool
baseCommand: PRScs.py
label: prscs_PRScs.py
doc: "PRScs: Polygenic Risk Score using continuous shrinkage. (Note: The provided
  text is a container runtime error log and does not contain CLI help information
  or argument definitions.)\n\nTool homepage: https://github.com/getian107/PRScs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prscs:1.1.0--hdfd78af_0
stdout: prscs_PRScs.py.out
