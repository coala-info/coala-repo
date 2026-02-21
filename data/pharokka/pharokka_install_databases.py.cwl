cwlVersion: v1.2
class: CommandLineTool
baseCommand: pharokka_install_databases.py
label: pharokka_install_databases.py
doc: "Install databases for pharokka (Note: The provided text is an error log and
  does not contain argument definitions).\n\nTool homepage: https://github.com/gbouras13/pharokka"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pharokka:1.9.1--pyhdfd78af_0
stdout: pharokka_install_databases.py.out
