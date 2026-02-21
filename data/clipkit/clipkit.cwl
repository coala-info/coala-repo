cwlVersion: v1.2
class: CommandLineTool
baseCommand: clipkit
label: clipkit
doc: "ClipKit is a tool for trimming multiple sequence alignments. (Note: The provided
  text is a container execution error log and does not contain help documentation;
  therefore, no arguments could be extracted.)\n\nTool homepage: https://github.com/jlsteenwyk/clipkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clipkit:2.7.0--pyhdfd78af_0
stdout: clipkit.out
