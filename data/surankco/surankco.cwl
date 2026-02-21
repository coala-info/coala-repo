cwlVersion: v1.2
class: CommandLineTool
baseCommand: surankco
label: surankco
doc: 'Supervised Ranking of Contigs (Note: The provided text contains environment
  logs and a fatal error rather than help documentation; no arguments could be extracted
  from the input).'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/surankco:v0.0.r5dfsg-2-deb_cv1
stdout: surankco.out
