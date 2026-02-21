cwlVersion: v1.2
class: CommandLineTool
baseCommand: samsift
label: samsift
doc: "A tool for filtering SAM/BAM files (Note: The provided text contains container
  runtime errors rather than help documentation).\n\nTool homepage: https://github.com/karel-brinda/samsift"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samsift:0.3.1--pyhdfd78af_0
stdout: samsift.out
