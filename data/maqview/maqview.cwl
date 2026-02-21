cwlVersion: v1.2
class: CommandLineTool
baseCommand: maqview
label: maqview
doc: The provided text does not contain help information for maqview; it contains
  system error messages regarding a container runtime failure (no space left on device).
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maqview:v0.2.5-9-deb_cv1
stdout: maqview.out
