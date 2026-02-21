cwlVersion: v1.2
class: CommandLineTool
baseCommand: dbcanlight
label: dbcanlight
doc: "A tool for automated Carbohydrate-active enZYmes (CAZyme) annotation (Note:
  The provided text contains container runtime errors rather than help documentation).\n
  \nTool homepage: https://github.com/chtsai0105/dbcanLight/tree/main"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dbcanlight:1.1.1--pyhdfd78af_0
stdout: dbcanlight.out
