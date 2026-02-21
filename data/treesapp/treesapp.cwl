cwlVersion: v1.2
class: CommandLineTool
baseCommand: treesapp
label: treesapp
doc: "TreeSAPP: Tree-based Sequence Annotation Publication Pipeline (Note: The provided
  text is an error log and does not contain help documentation or argument details).\n
  \nTool homepage: https://github.com/hallamlab/TreeSAPP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treesapp:0.11.4--py39h2de1943_2
stdout: treesapp.out
