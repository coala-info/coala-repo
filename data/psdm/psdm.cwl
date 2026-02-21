cwlVersion: v1.2
class: CommandLineTool
baseCommand: psdm
label: psdm
doc: "The provided text does not contain help information or usage instructions for
  the tool 'psdm'. It appears to be an error log from a container runtime (Apptainer/Singularity)
  failing to fetch or build the image.\n\nTool homepage: https://github.com/mbhall88/psdm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psdm:0.3.0--hc1c3326_2
stdout: psdm.out
