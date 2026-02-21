cwlVersion: v1.2
class: CommandLineTool
baseCommand: diphase_pipeline.py
label: diphase_pipeline.py
doc: "The provided text does not contain help information or usage instructions. It
  consists of system log messages and a fatal error regarding container image building
  (no space left on device).\n\nTool homepage: https://github.com/zhangjuncsu/Diphase"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diphase:1.0.3--h739ee2d_0
stdout: diphase_pipeline.py.out
