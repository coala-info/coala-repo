cwlVersion: v1.2
class: CommandLineTool
baseCommand: clermontyping
label: clermontyping
doc: "A tool for Clermont phylotyping of Escherichia coli. (Note: The provided help
  text contains only container build logs and error messages, so no specific arguments
  could be extracted.)\n\nTool homepage: https://github.com/happykhan/ClermonTyping"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clermontyping:24.02--py312hdfd78af_1
stdout: clermontyping.out
