cwlVersion: v1.2
class: CommandLineTool
baseCommand: bart-view
label: bart-view
doc: "The provided text contains system error messages (disk space exhaustion) rather
  than the help documentation for the tool. As a result, no arguments or descriptions
  could be extracted from the input.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart-view:v0.1.00-2-deb_cv1
stdout: bart-view.out
