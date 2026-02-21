cwlVersion: v1.2
class: CommandLineTool
baseCommand: staphb_toolkit
label: staphb_toolkit
doc: "The provided text appears to be a container runtime error log rather than help
  text. No command-line arguments, flags, or usage instructions were found in the
  input.\n\nTool homepage: https://staphb.org/staphb_toolkit/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/staphb_toolkit:2.0.1--pyhdfd78af_0
stdout: staphb_toolkit.out
