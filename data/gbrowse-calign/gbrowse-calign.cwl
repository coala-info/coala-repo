cwlVersion: v1.2
class: CommandLineTool
baseCommand: gbrowse-calign
label: gbrowse-calign
doc: A tool associated with GBrowse (Generic Genome Browser) for sequence alignment
  or calibration, though the provided text contains only container runtime error messages.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/gbrowse-calign:v2.56dfsg-2-deb_cv1
stdout: gbrowse-calign.out
