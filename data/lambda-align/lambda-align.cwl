cwlVersion: v1.2
class: CommandLineTool
baseCommand: lambda-align
label: lambda-align
doc: "Local Aligner for Massive Biological Data (Note: The provided text contains
  container runtime error logs rather than tool help text, so no arguments could be
  extracted).\n\nTool homepage: http://seqan.github.io/lambda/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/lambda-align:v1.0.3-5-deb_cv1
stdout: lambda-align.out
