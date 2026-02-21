cwlVersion: v1.2
class: CommandLineTool
baseCommand: lambda-align2
label: lambda-align2
doc: "The provided text is an error message from a container runtime and does not
  contain help information or a description for the tool.\n\nTool homepage: http://seqan.github.io/lambda/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/lambda-align2:v2.0.0-6-deb_cv1
stdout: lambda-align2.out
