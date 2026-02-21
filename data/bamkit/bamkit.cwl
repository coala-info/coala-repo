cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamkit
label: bamkit
doc: "A tool for processing BAM files (Note: The provided text contains container
  build errors rather than help documentation, so specific arguments could not be
  extracted).\n\nTool homepage: https://github.com/hall-lab/bamkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamkit:16.07.26--py_0
stdout: bamkit.out
