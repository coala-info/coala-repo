cwlVersion: v1.2
class: CommandLineTool
baseCommand: orientationpy
label: orientationpy
doc: "A tool for orientation analysis (Note: The provided help text contains only
  container runtime error messages and no CLI usage information).\n\nTool homepage:
  https://pypi.org/project/orientationpy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/orientationpy:0.2.0.4--pyhdfd78af_0
stdout: orientationpy.out
