cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfainject
label: gfainject
doc: "The provided text is a system error log (Apptainer/Singularity) and does not
  contain the help documentation for gfainject. As a result, no arguments could be
  extracted.\n\nTool homepage: https://github.com/AndreaGuarracino/gfainject"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfainject:0.2.0--h3ab6199_0
stdout: gfainject.out
