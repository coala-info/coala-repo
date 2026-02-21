cwlVersion: v1.2
class: CommandLineTool
baseCommand: bindashtree
label: bindashtree
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container build process.\n\nTool homepage: https://github.com/jianshu93/bindashtree"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bindashtree:0.1.1--h3ab6199_0
stdout: bindashtree.out
