cwlVersion: v1.2
class: CommandLineTool
baseCommand: degenotate
label: degenotate
doc: "A tool for degenotating sequences (Note: The provided help text contains only
  system error messages and no usage information).\n\nTool homepage: https://github.com/harvardinformatics/degenotate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/degenotate:1.3--pyhdfd78af_0
stdout: degenotate.out
