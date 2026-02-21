cwlVersion: v1.2
class: CommandLineTool
baseCommand: baczy
label: baczy
doc: "A tool for bacterial genome analysis (Note: The provided text is an error log
  from a container build and does not contain help documentation. Arguments could
  not be extracted from the provided input.)\n\nTool homepage: https://github.com/npbhavya/baczy/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/baczy:1.0.3--pyhdfd78af_0
stdout: baczy.out
