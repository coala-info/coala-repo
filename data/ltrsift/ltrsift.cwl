cwlVersion: v1.2
class: CommandLineTool
baseCommand: ltrsift
label: ltrsift
doc: "The provided text does not contain help information or a description of the
  tool's functionality; it contains error logs related to a container runtime failure
  (no space left on device).\n\nTool homepage: https://github.com/satta/ltrsift"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ltrsift:v1.0.2-8-deb_cv1
stdout: ltrsift.out
