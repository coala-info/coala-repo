cwlVersion: v1.2
class: CommandLineTool
baseCommand: eta
label: eta
doc: "The provided text does not contain help information for the tool 'eta'. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to pull an image due to lack of disk space.\n\nTool homepage: https://github.com/typelead/eta"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eta:0.9.7--py34_0
stdout: eta.out
