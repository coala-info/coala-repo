cwlVersion: v1.2
class: CommandLineTool
baseCommand: imputeme
label: imputeme
doc: "A tool for genetic imputation. (Note: The provided text is an error log from
  a container runtime and does not contain the tool's help documentation or argument
  definitions.)\n\nTool homepage: https://github.com/hshepard8/imputeme"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/imputeme:vv1.0.7_cv1
stdout: imputeme.out
