cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakeobjects
label: snakeobjects
doc: "Snakeobjects is a workflow management system. (Note: The provided text is a
  container build log and does not contain CLI help information or argument definitions.)\n
  \nTool homepage: https://github.com/iossifovlab/snakeobjects"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakeobjects:3.1.4--pyhdfd78af_0
stdout: snakeobjects.out
