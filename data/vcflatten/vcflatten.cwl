cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcflatten
label: vcflatten
doc: The provided text does not contain help information or a description of the tool.
  It appears to be a log of a failed container build/fetch process.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcflatten:0.5.2--0
stdout: vcflatten.out
