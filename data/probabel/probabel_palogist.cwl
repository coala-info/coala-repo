cwlVersion: v1.2
class: CommandLineTool
baseCommand: palogist
label: probabel_palogist
doc: "Logistic regression for genome-wide association analysis (Note: The provided
  text appears to be a container execution error log rather than the tool's help text,
  so no arguments could be extracted).\n\nTool homepage: https://github.com/GenABEL-Project/ProbABEL"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/probabel:v0.5.0dfsg-3-deb_cv1
stdout: probabel_palogist.out
