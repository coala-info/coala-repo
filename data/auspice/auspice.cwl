cwlVersion: v1.2
class: CommandLineTool
baseCommand: auspice
label: auspice
doc: "Auspice is an open-source tool for visualizing phylogenomic data. (Note: The
  provided text is a system error log regarding container execution and does not contain
  help documentation or argument definitions.)\n\nTool homepage: https://docs.nextstrain.org/projects/auspice/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/auspice:2.66.0--h503566f_2
stdout: auspice.out
