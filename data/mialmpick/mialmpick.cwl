cwlVersion: v1.2
class: CommandLineTool
baseCommand: mialmpick
label: mialmpick
doc: The provided text does not contain help information for mialmpick; it contains
  system error messages related to a container runtime failure (no space left on device).
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mialmpick:v0.2.14-2-deb_cv1
stdout: mialmpick.out
