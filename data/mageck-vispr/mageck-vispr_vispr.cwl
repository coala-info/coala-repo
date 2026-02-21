cwlVersion: v1.2
class: CommandLineTool
baseCommand: vispr
label: mageck-vispr_vispr
doc: "The provided text does not contain help information or usage instructions. It
  consists of system log messages and a fatal error regarding container image building
  (no space left on device).\n\nTool homepage: https://bitbucket.org/liulab/mageck-vispr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mageck-vispr:0.5.6--py_0
stdout: mageck-vispr_vispr.out
