cwlVersion: v1.2
class: CommandLineTool
baseCommand: parafly
label: parafly
doc: "The provided text does not contain help information for the tool 'parafly'.
  It contains system error messages related to a container runtime failure (no space
  left on device).\n\nTool homepage: https://github.com/ParaFly/ParaFly"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/parafly:v0.0.2013.01.21-4-deb_cv1
stdout: parafly.out
