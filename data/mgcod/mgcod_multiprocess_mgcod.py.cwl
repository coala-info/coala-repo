cwlVersion: v1.2
class: CommandLineTool
baseCommand: mgcod_multiprocess_mgcod.py
label: mgcod_multiprocess_mgcod.py
doc: "The provided text does not contain help information or usage instructions; it
  contains system log messages and a fatal error regarding container image conversion
  and disk space.\n\nTool homepage: https://github.com/gatech-genemark/Mgcod"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgcod:1.0.2--hdfd78af_0
stdout: mgcod_multiprocess_mgcod.py.out
