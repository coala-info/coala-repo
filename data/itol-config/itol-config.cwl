cwlVersion: v1.2
class: CommandLineTool
baseCommand: itol-config
label: itol-config
doc: "The provided text does not contain help information or a description of the
  tool. It contains error logs related to a container runtime (Apptainer/Singularity)
  failing to build the image due to lack of disk space.\n\nTool homepage: https://github.com/jodyphelan/itol-config"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/itol-config:0.1.0--pyhdfd78af_0
stdout: itol-config.out
