cwlVersion: v1.2
class: CommandLineTool
baseCommand: sicer
label: sicer
doc: "The provided text does not contain help information or usage instructions for
  the tool 'sicer'. It appears to be a log of a failed container build or image retrieval
  process.\n\nTool homepage: http://home.gwu.edu/~wpeng/Software.htm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sicer:1.1--np19py26_0
stdout: sicer.out
