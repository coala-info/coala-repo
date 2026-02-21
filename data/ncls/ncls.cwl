cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncls
label: ncls
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log regarding a container build failure due to insufficient
  disk space.\n\nTool homepage: http://github.com/hunt-genes/ncls"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncls:0.0.70--py39hbcbf7aa_0
stdout: ncls.out
