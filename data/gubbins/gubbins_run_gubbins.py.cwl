cwlVersion: v1.2
class: CommandLineTool
baseCommand: gubbins_run_gubbins.py
label: gubbins_run_gubbins.py
doc: "The provided text does not contain help information or usage instructions; it
  contains system log messages and a fatal error regarding container image building
  (no space left on device). No arguments could be extracted from the provided text.\n
  \nTool homepage: https://github.com/nickjcroucher/gubbins"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gubbins:3.4.3--py39h746d604_0
stdout: gubbins_run_gubbins.py.out
