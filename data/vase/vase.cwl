cwlVersion: v1.2
class: CommandLineTool
baseCommand: vase
label: vase
doc: "Variant Annotation, Selection and Evaluation (Note: The provided text is an
  error log from a container build process and does not contain CLI help information
  or argument definitions.)\n\nTool homepage: https://github.com/david-a-parry/vase"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vase:0.5.1--pyh086e186_0
stdout: vase.out
