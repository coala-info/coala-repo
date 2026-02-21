cwlVersion: v1.2
class: CommandLineTool
baseCommand: plinkio
label: plinkio
doc: "The provided text does not contain help documentation for the tool 'plinkio'.
  It contains error logs related to a failed container build process (Apptainer/Singularity)
  due to insufficient disk space.\n\nTool homepage: https://github.com/mfranberg/libplinkio"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plinkio:0.9.8--py310h4b81fae_0
stdout: plinkio.out
