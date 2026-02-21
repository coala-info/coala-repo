cwlVersion: v1.2
class: CommandLineTool
baseCommand: kronik
label: kronik
doc: "The provided text does not contain help information or usage instructions for
  the tool 'kronik'. It contains system error messages related to a container runtime
  (Apptainer/Singularity) failing to pull a Docker image due to insufficient disk
  space.\n\nTool homepage: https://github.com/kronik/DKLiveBlur"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kronik:2.20--h9948957_9
stdout: kronik.out
