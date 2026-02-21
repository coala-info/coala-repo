cwlVersion: v1.2
class: CommandLineTool
baseCommand: svict
label: svict
doc: "Structural Variant Identification from Circulating Tumor DNA (Note: The provided
  text is a container build error log and does not contain help information or argument
  definitions).\n\nTool homepage: https://github.com/vpc-ccg/svict"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svict:1.0.1--h077b44d_6
stdout: svict.out
