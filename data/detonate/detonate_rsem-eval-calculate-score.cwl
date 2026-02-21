cwlVersion: v1.2
class: CommandLineTool
baseCommand: rsem-eval-calculate-score
label: detonate_rsem-eval-calculate-score
doc: "The provided text does not contain help information for the tool. It contains
  system log messages indicating a failure to build or run the container image due
  to insufficient disk space.\n\nTool homepage: https://github.com/deweylab/detonate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/detonate:1.11--boost1.64_1
stdout: detonate_rsem-eval-calculate-score.out
