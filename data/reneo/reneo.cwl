cwlVersion: v1.2
class: CommandLineTool
baseCommand: reneo
label: reneo
doc: "The provided text does not contain help information or a description for the
  tool 'reneo'. It appears to be an error log from a container runtime (Apptainer/Singularity)
  failing to fetch the image.\n\nTool homepage: https://github.com/Vini2/phables"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reneo:0.5.0--pyhdfd78af_0
stdout: reneo.out
