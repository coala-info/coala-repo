cwlVersion: v1.2
class: CommandLineTool
baseCommand: domainator_build_ssn.py
label: domainator_build_ssn.py
doc: "The provided text does not contain help information for the tool, but appears
  to be a system error log regarding container image creation (no space left on device).\n
  \nTool homepage: https://github.com/nebiolabs/domainator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/domainator:0.8.0--pyhdfd78af_0
stdout: domainator_build_ssn.py.out
