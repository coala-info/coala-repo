cwlVersion: v1.2
class: CommandLineTool
baseCommand: lambda2
label: lambda_lambda2
doc: "The provided text does not contain help information for the tool. It is a system
  error log indicating a failure to build a Singularity/Apptainer container due to
  insufficient disk space.\n\nTool homepage: http://seqan.github.io/lambda/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lambda:3.1.0--haf24da9_1
stdout: lambda_lambda2.out
