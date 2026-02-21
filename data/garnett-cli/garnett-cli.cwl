cwlVersion: v1.2
class: CommandLineTool
baseCommand: garnett-cli
label: garnett-cli
doc: "Garnett is a tool for cell type classification. (Note: The provided help text
  contains only container runtime error messages and does not list specific command-line
  arguments.)\n\nTool homepage: https://github.com/ebi-gene-expression-group/garnett-cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/garnett-cli:0.0.5--hdfd78af_1
stdout: garnett-cli.out
