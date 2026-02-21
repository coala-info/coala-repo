cwlVersion: v1.2
class: CommandLineTool
baseCommand: mageck-vispr
label: mageck-vispr
doc: "The provided text does not contain help information or a description of the
  tool; it contains system log messages and a fatal error regarding container image
  building.\n\nTool homepage: https://bitbucket.org/liulab/mageck-vispr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mageck-vispr:0.5.6--py_0
stdout: mageck-vispr.out
