cwlVersion: v1.2
class: CommandLineTool
baseCommand: dimspy
label: dimspy
doc: "Direct Infusion Mass Spectrometry Processing in Python (Note: The provided text
  contains container runtime error logs and does not include the tool's help documentation
  or usage instructions).\n\nTool homepage: https://github.com/computational-metabolomics/dimspy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dimspy:2.0.0--pyhdfd78af_1
stdout: dimspy.out
