cwlVersion: v1.2
class: CommandLineTool
baseCommand: profnet-isis
label: profnet-isis
doc: 'A tool for protein-protein interaction site prediction (Note: The provided text
  contains container runtime error messages rather than tool help text, so arguments
  could not be extracted).'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/profnet-isis:v1.0.22-6-deb_cv1
stdout: profnet-isis.out
