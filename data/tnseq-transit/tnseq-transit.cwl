cwlVersion: v1.2
class: CommandLineTool
baseCommand: tnseq-transit
label: tnseq-transit
doc: 'Analysis of Tn-Seq datasets. Note: The provided help text contains container
  runtime errors and does not list specific command-line arguments.'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/tnseq-transit:v2.3.4-1-deb_cv1
stdout: tnseq-transit.out
