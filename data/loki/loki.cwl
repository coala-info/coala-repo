cwlVersion: v1.2
class: CommandLineTool
baseCommand: loki
label: loki
doc: "Loki is a suite of programs for linkage analysis of general pedigrees, performing
  Monte Carlo multipoint linkage analysis.\n\nTool homepage: https://github.com/grafana/loki"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/loki:v2.4.7.4-8-deb_cv1
stdout: loki.out
