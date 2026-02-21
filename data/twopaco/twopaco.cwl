cwlVersion: v1.2
class: CommandLineTool
baseCommand: twopaco
label: twopaco
doc: "The provided text does not contain help information for the twopaco tool; it
  is an error log from a container runtime (Apptainer/Singularity) indicating a failure
  to build the image due to insufficient disk space.\n\nTool homepage: https://github.com/medvedevgroup/TwoPaCo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/twopaco:1.1.0--hc252753_1
stdout: twopaco.out
