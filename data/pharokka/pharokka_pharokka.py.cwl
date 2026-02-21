cwlVersion: v1.2
class: CommandLineTool
baseCommand: pharokka.py
label: pharokka_pharokka.py
doc: "A rapid bacteriophage genome annotation pipeline.\n\nTool homepage: https://github.com/gbouras13/pharokka"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pharokka:1.9.1--pyhdfd78af_0
stdout: pharokka_pharokka.py.out
