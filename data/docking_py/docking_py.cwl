cwlVersion: v1.2
class: CommandLineTool
baseCommand: docking_py
label: docking_py
doc: "The provided text does not contain help information or usage instructions. It
  consists of system log messages and a fatal error regarding disk space during a
  container build process.\n\nTool homepage: https://github.com/samuelmurail/docking_py"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/docking_py:0.2.3--py_0
stdout: docking_py.out
