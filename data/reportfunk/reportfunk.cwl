cwlVersion: v1.2
class: CommandLineTool
baseCommand: reportfunk
label: reportfunk
doc: "The provided text does not contain help documentation or usage instructions;
  it is a log of a failed container build/fetch process. Consequently, no arguments
  or descriptions could be extracted.\n\nTool homepage: https://github.com/cov-ert/reportfunk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reportfunk:1.0.1--pyh3252c3a_0
stdout: reportfunk.out
