cwlVersion: v1.2
class: CommandLineTool
baseCommand: tagore
label: tagore
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build/fetch process.\n\nTool homepage: https://github.com/jordanlab/tagore"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tagore:1.1.2--pyhdfd78af_0
stdout: tagore.out
