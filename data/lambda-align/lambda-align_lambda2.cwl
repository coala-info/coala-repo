cwlVersion: v1.2
class: CommandLineTool
baseCommand: lambda2
label: lambda-align_lambda2
doc: "The provided text does not contain help information for the tool, but rather
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to build the image due to insufficient disk space.\n\nTool homepage: http://seqan.github.io/lambda/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/lambda-align:v1.0.3-5-deb_cv1
stdout: lambda-align_lambda2.out
