cwlVersion: v1.2
class: CommandLineTool
baseCommand: vispr
label: vispr
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container build process.\n\nTool homepage: https://bitbucket.org/liulab/vispr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vispr:0.4.17--pyh7cba7a3_1
stdout: vispr.out
