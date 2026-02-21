cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyling
label: phyling
doc: "Phylogenomic data processing tool (Note: The provided text is a container build
  log and does not contain help documentation or argument definitions).\n\nTool homepage:
  https://github.com/stajichlab/Phyling"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyling:2.3.1--pyhdfd78af_0
stdout: phyling.out
