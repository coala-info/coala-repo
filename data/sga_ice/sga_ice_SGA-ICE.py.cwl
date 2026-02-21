cwlVersion: v1.2
class: CommandLineTool
baseCommand: sga_ice_SGA-ICE.py
label: sga_ice_SGA-ICE.py
doc: "Iterative Correction Engine (ICE) from the String Graph Assembler (SGA) toolkit.
  Note: The provided help text contains only system error logs regarding a failed
  container build and does not list command-line arguments.\n\nTool homepage: https://github.com/hillerlab/IterativeErrorCorrection"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sga:v0.10.15-4-deb_cv1
stdout: sga_ice_SGA-ICE.py.out
