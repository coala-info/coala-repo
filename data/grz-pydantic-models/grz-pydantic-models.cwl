cwlVersion: v1.2
class: CommandLineTool
baseCommand: grz-pydantic-models
label: grz-pydantic-models
doc: "The provided text does not contain help information or a description of the
  tool's functionality; it contains error logs related to a container runtime environment.\n
  \nTool homepage: https://github.com/BfArM-MVH/grz-pydantic-models"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grz-pydantic-models:2.5.0--pyh0648b3f_0
stdout: grz-pydantic-models.out
