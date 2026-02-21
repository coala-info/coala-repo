cwlVersion: v1.2
class: CommandLineTool
baseCommand: hdmi
label: hdmi
doc: "The provided text does not contain help information for the tool 'hdmi'. It
  is an error log from a container runtime (Apptainer/Singularity) indicating a failure
  to pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/HaoranPeng21/HDMI"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hdmi:1.0.0--pyhdfd78af_0
stdout: hdmi.out
