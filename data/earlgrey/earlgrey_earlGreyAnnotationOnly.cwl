cwlVersion: v1.2
class: CommandLineTool
baseCommand: earlGreyAnnotationOnly
label: earlgrey_earlGreyAnnotationOnly
doc: "The provided text is an error log from a container runtime and does not contain
  help information or usage instructions for the tool. As a result, no arguments could
  be extracted.\n\nTool homepage: https://github.com/TobyBaril/EarlGrey"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/earlgrey:7.0.1--h9948957_1
stdout: earlgrey_earlGreyAnnotationOnly.out
