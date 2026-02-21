cwlVersion: v1.2
class: CommandLineTool
baseCommand: chia-rep_script.py
label: chia-rep_script.py
doc: "The provided text does not contain help information or usage instructions for
  chia-rep_script.py. It contains system log messages and a fatal error regarding
  a container build failure (no space left on device).\n\nTool homepage: https://github.com/c0ver/chia_rep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chia-rep:3.1.1--py310h068649b_3
stdout: chia-rep_script.py.out
