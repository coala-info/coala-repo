cwlVersion: v1.2
class: CommandLineTool
baseCommand: pydamage
label: pydamage
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build/execution attempt.\n\nTool homepage:
  https://github.com/maxibor/pydamage"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pydamage:1.0--pyhdfd78af_0
stdout: pydamage.out
