cwlVersion: v1.2
class: CommandLineTool
baseCommand: svtk
label: svtk
doc: "Structural variation toolkit (Note: The provided text is a container build error
  log and does not contain help documentation or argument definitions).\n\nTool homepage:
  https://github.com/talkowski-lab/svtk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtk:0.0.20190615--py39hbcbf7aa_7
stdout: svtk.out
