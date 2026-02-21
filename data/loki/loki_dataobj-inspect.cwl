cwlVersion: v1.2
class: CommandLineTool
baseCommand: loki_dataobj-inspect
label: loki_dataobj-inspect
doc: "The provided text does not contain help information for the tool, but appears
  to be a system error log related to a container execution failure (no space left
  on device).\n\nTool homepage: https://github.com/grafana/loki"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/loki:v2.4.7.4-8-deb_cv1
stdout: loki_dataobj-inspect.out
