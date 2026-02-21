cwlVersion: v1.2
class: CommandLineTool
baseCommand: fpa
label: fpa
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation for the tool 'fpa'. As a result, no
  arguments could be extracted.\n\nTool homepage: https://github.com/natir/yacrd"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fpa:0.5.1--heebf65f_6
stdout: fpa.out
