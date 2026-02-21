cwlVersion: v1.2
class: CommandLineTool
baseCommand: lrsim_simulateLinkedReads.pl
label: lrsim_simulateLinkedReads.pl
doc: "Simulate linked reads (Note: The provided help text contains only container
  runtime errors and no usage information).\n\nTool homepage: https://github.com/aquaskyline/LRSIM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lrsim:1.0--pl5321hbcd995c_0
stdout: lrsim_simulateLinkedReads.pl.out
