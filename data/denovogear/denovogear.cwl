cwlVersion: v1.2
class: CommandLineTool
baseCommand: denovogear
label: denovogear
doc: "A tool for detecting de novo mutations from next-generation sequencing data.
  (Note: The provided input text is a system error message regarding container execution
  and does not contain help documentation or argument definitions.)\n\nTool homepage:
  https://github.com/ultimatesource/denovogear"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/denovogear:1.1.1--boost1.60_0
stdout: denovogear.out
