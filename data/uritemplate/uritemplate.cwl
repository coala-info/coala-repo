cwlVersion: v1.2
class: CommandLineTool
baseCommand: uritemplate
label: uritemplate
doc: "The provided text does not contain help information for the 'uritemplate' tool;
  it is a log of a failed container build/fetch process (Apptainer/Singularity).\n
  \nTool homepage: https://github.com/rize/UriTemplate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/uritemplate:0.6--py36_0
stdout: uritemplate.out
