cwlVersion: v1.2
class: CommandLineTool
baseCommand: spingo_showlog
label: spingo_showlog
doc: "The provided text does not contain help documentation for the tool, but appears
  to be a log of a failed container build or execution attempt.\n\nTool homepage:
  https://github.com/homedepot/spingo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spingo:1.3
stdout: spingo_showlog.out
