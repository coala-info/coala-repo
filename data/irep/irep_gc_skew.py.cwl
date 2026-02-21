cwlVersion: v1.2
class: CommandLineTool
baseCommand: irep_gc_skew.py
label: irep_gc_skew.py
doc: "The provided text does not contain help information for the tool. It contains
  system logs and a fatal error indicating a failure to build the container image
  due to lack of disk space.\n\nTool homepage: https://github.com/christophertbrown/iRep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/irep:1.1.7--pyh24bf2e0_1
stdout: irep_gc_skew.py.out
