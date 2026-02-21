cwlVersion: v1.2
class: CommandLineTool
baseCommand: isatab-create
label: isatab-create
doc: "The provided text does not contain help information or a description of the
  tool's functionality; it contains system error messages regarding a container build
  failure.\n\nTool homepage: https://github.com/phnmnl/container-isatab-create"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/isatab-create:v0.9.5_cv0.3.14
stdout: isatab-create.out
