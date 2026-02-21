cwlVersion: v1.2
class: CommandLineTool
baseCommand: logcli
label: loki_LogCLI
doc: "The provided text does not contain help information or usage instructions; it
  is an error log from a container runtime (Singularity/Apptainer) indicating a failure
  to build a SIF image due to insufficient disk space.\n\nTool homepage: https://github.com/grafana/loki"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/loki:v2.4.7.4-8-deb_cv1
stdout: loki_LogCLI.out
