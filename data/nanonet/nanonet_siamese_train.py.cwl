cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanonet_siamese_train.py
label: nanonet_siamese_train.py
doc: "The provided text does not contain help information or usage instructions. It
  contains system log messages and a fatal error regarding container execution (no
  space left on device).\n\nTool homepage: https://github.com/abhyantrika/nanonets_object_tracking"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanonet:2.0.0--boost1.64_0
stdout: nanonet_siamese_train.py.out
