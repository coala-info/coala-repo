cwlVersion: v1.2
class: CommandLineTool
baseCommand: hormon
label: hormon
doc: "The provided text does not contain help information for the tool 'hormon'. It
  contains error messages from a container runtime (Apptainer/Singularity) indicating
  a failure to build the container image due to insufficient disk space.\n\nTool homepage:
  https://github.com/ablab/HORmon"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hormon:1.0.0--pyhdfd78af_0
stdout: hormon.out
