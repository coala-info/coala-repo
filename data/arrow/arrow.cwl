cwlVersion: v1.2
class: CommandLineTool
baseCommand: arrow
label: arrow
doc: "The provided text does not contain help information or a description for the
  tool 'arrow'. It appears to be a log of a failed execution attempt where the executable
  was not found.\n\nTool homepage: https://github.com/apache/arrow"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/arrow:0.7.0--py36_0
stdout: arrow.out
