cwlVersion: v1.2
class: CommandLineTool
baseCommand: irep
label: irep
doc: "The provided text does not contain help information for the tool 'irep'. It
  contains system log messages and a fatal error related to a container runtime (Apptainer/Singularity)
  failing to build an image due to insufficient disk space.\n\nTool homepage: https://github.com/christophertbrown/iRep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/irep:1.1.7--pyh24bf2e0_1
stdout: irep.out
