cwlVersion: v1.2
class: CommandLineTool
baseCommand: pegasuspy
label: pegasuspy
doc: "The provided text does not contain help information or usage instructions. It
  consists of system error messages related to a lack of disk space during a container
  image pull.\n\nTool homepage: https://github.com/klarman-cell-observatory/pegasus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pegasuspy:1.10.2--py311haab0aaa_0
stdout: pegasuspy.out
