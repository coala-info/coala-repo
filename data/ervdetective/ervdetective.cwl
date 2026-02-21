cwlVersion: v1.2
class: CommandLineTool
baseCommand: ervdetective
label: ervdetective
doc: "A tool for detecting Endogenous Retroviruses (ERVs). Note: The provided text
  contains system error logs rather than help documentation, so no arguments could
  be extracted.\n\nTool homepage: https://github.com/ZhijianZhou01/ervdetective"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ervdetective:1.0.9--pyhdfd78af_1
stdout: ervdetective.out
