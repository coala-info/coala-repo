cwlVersion: v1.2
class: CommandLineTool
baseCommand: flagx
label: flagx
doc: "A tool for expanding SAM flags into a more readable format (Note: The provided
  text is a container build log and does not contain help documentation. Arguments
  could not be extracted from the input.)\n\nTool homepage: https://github.com/bionetslab/FLAG-X"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flagx:0.2.0--pyhdfd78af_0
stdout: flagx.out
