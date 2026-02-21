cwlVersion: v1.2
class: CommandLineTool
baseCommand: dudes
label: dudes
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help documentation or usage information for the 'dudes' tool.\n
  \nTool homepage: https://github.com/pirovc/dudes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dudes:0.10.0--pyhdfd78af_0
stdout: dudes.out
