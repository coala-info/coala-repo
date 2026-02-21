cwlVersion: v1.2
class: CommandLineTool
baseCommand: profnet-norsnet
label: profnet-norsnet
doc: A tool for predicting non-regular secondary structure (NORS) regions in protein
  sequences.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/profnet-norsnet:v1.0.22-6-deb_cv1
stdout: profnet-norsnet.out
