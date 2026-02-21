cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxonomy
label: taxonomy
doc: "A tool for taxonomy-related processing (Note: The provided text contains container
  build logs rather than command-line help documentation, so no arguments could be
  extracted).\n\nTool homepage: https://github.com/onecodex/taxonomy/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxonomy:0.10.2--py310h9e6395a_0
stdout: taxonomy.out
