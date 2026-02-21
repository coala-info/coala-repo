cwlVersion: v1.2
class: CommandLineTool
baseCommand: enviroampdesigner_run.py
label: enviroampdesigner_run.py
doc: "A tool for environmental amplicon design. (Note: The provided help text contains
  system error logs regarding container image building and disk space, rather than
  command-line usage instructions; therefore, no arguments could be extracted.)\n\n
  Tool homepage: https://github.com/AntonS-bio/EnviroAmpDesigner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enviroampdesigner:0.1.3--pyhdfd78af_0
stdout: enviroampdesigner_run.py.out
