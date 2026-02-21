cwlVersion: v1.2
class: CommandLineTool
baseCommand: srst2_getmlst.py
label: srst2_getmlst.py
doc: "A tool for retrieving MLST (Multi-Locus Sequence Typing) data for use with SRST2.
  (Note: The provided help text contains only system error messages and no usage information
  or arguments.)\n\nTool homepage: https://github.com/katholt/srst2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/srst2:v0.2.0-6-deb_cv1
stdout: srst2_getmlst.py.out
