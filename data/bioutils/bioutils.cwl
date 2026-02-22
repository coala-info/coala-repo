cwlVersion: v1.2
class: CommandLineTool
baseCommand: bioutils
label: bioutils
doc: "The provided text is an error log related to a container runtime failure (no
  space left on device) and does not contain help information or argument definitions
  for the tool.\n\nTool homepage: https://github.com/biocommons/bioutils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioutils:0.6.1--pyhdfd78af_0
stdout: bioutils.out
