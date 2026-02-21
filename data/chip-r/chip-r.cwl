cwlVersion: v1.2
class: CommandLineTool
baseCommand: chip-r
label: chip-r
doc: "The provided text does not contain help information or usage instructions for
  the tool 'chip-r'. It contains error logs related to a container runtime (Apptainer/Singularity)
  failing to pull or build the image due to insufficient disk space.\n\nTool homepage:
  https://github.com/rhysnewell/ChIP-R"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chip-r:1.2.0--pyh3252c3a_0
stdout: chip-r.out
