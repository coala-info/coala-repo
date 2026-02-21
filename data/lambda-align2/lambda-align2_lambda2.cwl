cwlVersion: v1.2
class: CommandLineTool
baseCommand: lambda2
label: lambda-align2_lambda2
doc: "Lambda2: Local Aligner for Massive Biological Data. (Note: The provided text
  contains container runtime error messages rather than tool help text; therefore,
  no arguments could be extracted.)\n\nTool homepage: http://seqan.github.io/lambda/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/lambda-align2:v2.0.0-6-deb_cv1
stdout: lambda-align2_lambda2.out
