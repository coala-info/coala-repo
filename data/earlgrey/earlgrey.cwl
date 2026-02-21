cwlVersion: v1.2
class: CommandLineTool
baseCommand: earlgrey
label: earlgrey
doc: "Earl Grey is a fully automated transposable element (TE) annotation pipeline.
  (Note: The provided input text contains container runtime error messages and does
  not include the tool's help documentation or argument definitions.)\n\nTool homepage:
  https://github.com/TobyBaril/EarlGrey"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/earlgrey:7.0.1--h9948957_1
stdout: earlgrey.out
