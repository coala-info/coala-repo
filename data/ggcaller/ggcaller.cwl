cwlVersion: v1.2
class: CommandLineTool
baseCommand: ggcaller
label: ggcaller
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log reporting a failure to build a container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/samhorsfield96/ggCaller"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ggcaller:1.4.3--py39h3961c5e_0
stdout: ggcaller.out
