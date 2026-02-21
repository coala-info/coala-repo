cwlVersion: v1.2
class: CommandLineTool
baseCommand: profnet-con
label: profnet-con
doc: 'A tool for protein contact prediction. (Note: The provided text contains container
  runtime logs rather than CLI help documentation; therefore, specific arguments could
  not be extracted from the input.)'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/profnet-con:v1.0.22-6-deb_cv1
stdout: profnet-con.out
