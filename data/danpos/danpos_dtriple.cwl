cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - danpos
  - dtriple
label: danpos_dtriple
doc: "The provided text does not contain the help documentation for danpos_dtriple;
  it contains system logs and a fatal error indicating a failure to build or run the
  container due to lack of disk space. No arguments could be extracted from the provided
  text.\n\nTool homepage: https://sites.google.com/site/danposdoc/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/danpos:v2.2.2_cv3
stdout: danpos_dtriple.out
