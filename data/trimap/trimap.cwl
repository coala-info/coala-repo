cwlVersion: v1.2
class: CommandLineTool
baseCommand: trimap
label: trimap
doc: "TriMap is a dimensionality reduction method that uses triplet constraints to
  preserve both local and global structure of the data.\n\nTool homepage: http://github.com/eamid/trimap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trimap:1.0.15--pyh5e36f6f_0
stdout: trimap.out
