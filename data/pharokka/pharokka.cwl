cwlVersion: v1.2
class: CommandLineTool
baseCommand: pharokka
label: pharokka
doc: "A tool for rapid phage genome annotation and visualization. (Note: The provided
  input text appears to be a container execution error log rather than the standard
  help output; therefore, specific arguments could not be extracted from this text.)\n
  \nTool homepage: https://github.com/gbouras13/pharokka"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pharokka:1.9.1--pyhdfd78af_0
stdout: pharokka.out
