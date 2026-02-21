cwlVersion: v1.2
class: CommandLineTool
baseCommand: qcli_logiq
label: qcli_logiq
doc: "The provided text does not contain help information or usage instructions for
  the tool; it appears to be a log of a failed container build process.\n\nTool homepage:
  https://github.com/xyOz-dev/LogiQCLI"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/qcli:v0.1.1-3-deb-py2_cv1
stdout: qcli_logiq.out
