cwlVersion: v1.2
class: CommandLineTool
baseCommand: circminer
label: circminer
doc: "A tool for circular RNA detection (Note: The provided text is a container execution
  error log and does not contain CLI help information; therefore, no arguments could
  be extracted).\n\nTool homepage: https://github.com/vpc-ccg/circminer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/circminer:0.4.2--h5ca1c30_6
stdout: circminer.out
