cwlVersion: v1.2
class: CommandLineTool
baseCommand: profnet-bval
label: profnet-bval
doc: A tool for predicting B-values (protein flexibility) from protein sequences.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/profnet-bval:v1.0.22-6-deb_cv1
stdout: profnet-bval.out
