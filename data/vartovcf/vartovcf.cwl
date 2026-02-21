cwlVersion: v1.2
class: CommandLineTool
baseCommand: vartovcf
label: vartovcf
doc: "The provided text does not contain help information for the tool; it contains
  container runtime logs and a fatal error message. No arguments or tool descriptions
  could be extracted from this input.\n\nTool homepage: https://github.com/clintval/vartovcf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vartovcf:1.4.0--h3ab6199_0
stdout: vartovcf.out
