cwlVersion: v1.2
class: CommandLineTool
baseCommand: hinge
label: hinge
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation for the 'hinge' tool. As a result, no
  arguments could be extracted.\n\nTool homepage: https://github.com/Rocktopus101/Hingemonium"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/hinge:v0.5.0-4-deb_cv1
stdout: hinge.out
