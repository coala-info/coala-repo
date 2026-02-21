cwlVersion: v1.2
class: CommandLineTool
baseCommand: desman
label: desman
doc: "The provided text does not contain help information for the tool 'desman'. It
  contains system error messages related to a container runtime (Apptainer/Singularity)
  failing to pull an image due to insufficient disk space.\n\nTool homepage: https://github.com/chrisquince/DESMAN"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/desman:2.1--py39h4747326_10
stdout: desman.out
