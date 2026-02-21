cwlVersion: v1.2
class: CommandLineTool
baseCommand: setsimilaritysearch
label: setsimilaritysearch
doc: "The provided text does not contain help information or a description of the
  tool. It is an error log indicating a failure to build or run a container image
  due to insufficient disk space.\n\nTool homepage: https://github.com/ekzhu/SetSimilaritySearch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/setsimilaritysearch:1.0.0
stdout: setsimilaritysearch.out
