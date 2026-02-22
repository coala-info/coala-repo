cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbbanana
label: pbbanana
doc: The provided text contains system error messages regarding a failed 
  container execution and does not include help documentation or usage 
  instructions for the tool.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pbbanana:v15.8.24dfsg-3-deb-py2_cv1
stdout: pbbanana.out
