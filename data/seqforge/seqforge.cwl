cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqforge
label: seqforge
doc: "The provided text does not contain help documentation or usage instructions
  for seqforge; it is a system error log indicating a failure to build or run a container
  due to insufficient disk space.\n\nTool homepage: https://github.com/ERBringHorvath/SeqForge"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqforge:2.0.0--pyh7e72e81_0
stdout: seqforge.out
