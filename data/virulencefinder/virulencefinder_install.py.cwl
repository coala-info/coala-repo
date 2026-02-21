cwlVersion: v1.2
class: CommandLineTool
baseCommand: virulencefinder_install.py
label: virulencefinder_install.py
doc: "Installation script for VirulenceFinder. Note: The provided text contains execution
  logs and error messages rather than help documentation, so no arguments could be
  extracted.\n\nTool homepage: https://bitbucket.org/genomicepidemiology/virulencefinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virulencefinder:3.2.0--pyhdfd78af_0
stdout: virulencefinder_install.py.out
