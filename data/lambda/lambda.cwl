cwlVersion: v1.2
class: CommandLineTool
baseCommand: lambda
label: lambda
doc: "The provided text does not contain help information or usage instructions for
  the tool 'lambda'. It contains error logs related to a container runtime (Apptainer/Singularity)
  failing to build a SIF image due to insufficient disk space.\n\nTool homepage: http://seqan.github.io/lambda/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lambda:3.1.0--haf24da9_1
stdout: lambda.out
