cwlVersion: v1.2
class: CommandLineTool
baseCommand: visionegg_check-config.py
label: visionegg_check-config.py
doc: "Check the configuration of VisionEgg.\n\nTool homepage: https://github.com/visionegg/visionegg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/visionegg:v1.2.1-2-deb-py2_cv1
stdout: visionegg_check-config.py.out
