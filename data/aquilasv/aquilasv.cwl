cwlVersion: v1.2
class: CommandLineTool
baseCommand: aquilasv
label: aquilasv
doc: "AquilaSV is a tool for structural variant (SV) calling. (Note: The provided
  text was a system error log and did not contain usage instructions or argument definitions.)\n\
  \nTool homepage: https://github.com/maiziezhoulab/AquilaSV"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aquilasv:1.5--pyhdfd78af_0
stdout: aquilasv.out
