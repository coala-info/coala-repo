cwlVersion: v1.2
class: CommandLineTool
baseCommand: ref-eval-estimate-true-assembly
label: detonate_ref-eval-estimate-true-assembly
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error indicating a failure to build or run the container
  image due to insufficient disk space.\n\nTool homepage: https://github.com/deweylab/detonate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/detonate:1.11--boost1.64_1
stdout: detonate_ref-eval-estimate-true-assembly.out
