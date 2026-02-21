cwlVersion: v1.2
class: CommandLineTool
baseCommand: hmtnote
label: hmtnote
doc: "Human Mitochondrial variant Annotation tool (Note: The provided help text contains
  only system error messages and no usage information).\n\nTool homepage: https://github.com/robertopreste/hmtnote"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmtnote:0.7.2--pyhdfd78af_1
stdout: hmtnote.out
