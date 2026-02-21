cwlVersion: v1.2
class: CommandLineTool
baseCommand: rtax
label: rtax
doc: "Rapid Taxonomic Assignment of rRNA gene sequences (Note: The provided text contains
  system error logs rather than tool help documentation, so no arguments could be
  extracted).\n\nTool homepage: https://github.com/SWRT-dev/rtax89x"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rtax:v0.984-6-deb_cv1
stdout: rtax.out
