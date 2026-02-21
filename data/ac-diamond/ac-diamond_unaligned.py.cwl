cwlVersion: v1.2
class: CommandLineTool
baseCommand: ac-diamond_unaligned.py
label: ac-diamond_unaligned.py
doc: "The provided text does not contain help information or usage instructions for
  ac-diamond_unaligned.py. It contains system log messages and a fatal error regarding
  a container build failure (no space left on device).\n\nTool homepage: https://github.com/Maihj/AC-DIAMOND"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ac-diamond:1.0--boost1.64_0
stdout: ac-diamond_unaligned.py.out
