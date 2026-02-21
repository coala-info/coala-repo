cwlVersion: v1.2
class: CommandLineTool
baseCommand: visitor
label: visitor
doc: "The provided text does not contain help information or a description of the
  tool's functionality. It appears to be a log of a failed container build or execution
  attempt.\n\nTool homepage: https://github.com/rahuldkjain/github-profile-readme-generator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/visitor:0.1.2--py35_0
stdout: visitor.out
