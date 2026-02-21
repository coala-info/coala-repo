cwlVersion: v1.2
class: CommandLineTool
baseCommand: cloudspades
label: cloudspades
doc: "CloudSPAdes is a tool for genome assembly designed for cloud computing environments.
  (Note: The provided text is a container execution error log and does not contain
  CLI help documentation; therefore, no arguments could be extracted.)\n\nTool homepage:
  https://github.com/ablab/spades"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cloudspades:3.16.0--haf24da9_3
stdout: cloudspades.out
