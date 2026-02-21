cwlVersion: v1.2
class: CommandLineTool
baseCommand: PhiSpy.py
label: phispy_PhiSpy.py
doc: "PhiSpy is a tool for identifying prophages in bacterial genomes. (Note: The
  provided help text contains only container execution errors and does not list specific
  arguments.)\n\nTool homepage: https://github.com/linsalrob/PhiSpy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phispy:4.2.21--py310h0dbaff4_2
stdout: phispy_PhiSpy.py.out
