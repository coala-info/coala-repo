cwlVersion: v1.2
class: CommandLineTool
baseCommand: vmd
label: vmd
doc: "Visual Molecular Dynamics (VMD) is a molecular visualization program for displaying,
  animating, and analyzing large biomolecular systems using 3D graphics and built-in
  scripting.\n\nTool homepage: https://github.com/yoshuawuyts/vmd"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vmd:1.9.3
stdout: vmd.out
