cwlVersion: v1.2
class: CommandLineTool
baseCommand: methylmap_multiparsetable.py
label: methylmap_multiparsetable.py
doc: "A script for parsing tables within the methylmap tool suite. (Note: The provided
  input text contains container runtime error messages and does not include the actual
  help documentation for the tool's arguments.)\n\nTool homepage: https://github.com/EliseCoopman/methylmap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methylmap:0.5.11--pyhdfd78af_0
stdout: methylmap_multiparsetable.py.out
