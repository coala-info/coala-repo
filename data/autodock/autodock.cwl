cwlVersion: v1.2
class: CommandLineTool
baseCommand: autodock
label: autodock
doc: "AutoDock is a suite of automated docking tools designed to predict how small
  molecules bind to a receptor of known 3D structure.\n\nTool homepage: http://autodock.scripps.edu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/autodock:v4.2.6-6-deb_cv1
stdout: autodock.out
