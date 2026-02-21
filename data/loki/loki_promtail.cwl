cwlVersion: v1.2
class: CommandLineTool
baseCommand: promtail
label: loki_promtail
doc: "The provided text does not contain help information or usage instructions; it
  consists of system logs and a fatal error indicating a failure to build or run the
  container image due to lack of disk space.\n\nTool homepage: https://github.com/grafana/loki"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/loki:v2.4.7.4-8-deb_cv1
stdout: loki_promtail.out
