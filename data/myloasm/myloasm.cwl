cwlVersion: v1.2
class: CommandLineTool
baseCommand: myloasm
label: myloasm
doc: "The provided text is an error message from a container runtime (Apptainer/Singularity)
  indicating a failure to pull or build the container image due to insufficient disk
  space. It does not contain help text or usage information for the tool 'myloasm'.\n
  \nTool homepage: https://github.com/bluenote-1577/myloasm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/myloasm:0.4.0--ha6fb395_0
stdout: myloasm.out
