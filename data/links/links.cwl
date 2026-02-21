cwlVersion: v1.2
class: CommandLineTool
baseCommand: links
label: links
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log reporting a failure to build a SIF container due to insufficient
  disk space.\n\nTool homepage: https://github.com/bcgsc/LINKS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/links:2.0.1--h9948957_7
stdout: links.out
