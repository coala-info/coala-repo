cwlVersion: v1.2
class: CommandLineTool
baseCommand: chopper
label: chopper
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help text or usage information for the tool 'chopper'.
  As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/wdecoster/chopper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chopper:0.12.0--hcdda2d0_0
stdout: chopper.out
