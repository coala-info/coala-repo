cwlVersion: v1.2
class: CommandLineTool
baseCommand: unifeb
label: unifeb
doc: "The provided text contains container build logs rather than tool help documentation.
  No arguments or descriptions could be extracted.\n\nTool homepage: https://github.com/jianshu93/unifeb.git"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unifeb:0.1.1--h3ab6199_0
stdout: unifeb.out
