cwlVersion: v1.2
class: CommandLineTool
baseCommand: hafez_hafeZ.py
label: hafez_hafeZ.py
doc: "A tool from the hafez package (description unavailable due to error in provided
  help text).\n\nTool homepage: https://github.com/Chrisjrt/hafeZ"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hafez:1.0.4--pyh7cba7a3_0
stdout: hafez_hafeZ.py.out
