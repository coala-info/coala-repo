cwlVersion: v1.2
class: CommandLineTool
baseCommand: hlafreq
label: hlafreq
doc: "HLA frequency analysis tool (Note: The provided text contains container runtime
  error messages and does not include the actual help documentation or usage instructions
  for the tool).\n\nTool homepage: https://github.com/Vaccitech/HLAfreq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hlafreq:0.0.5--pyhdfd78af_0
stdout: hlafreq.out
