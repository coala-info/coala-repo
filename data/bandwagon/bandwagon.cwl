cwlVersion: v1.2
class: CommandLineTool
baseCommand: bandwagon
label: bandwagon
doc: "The provided text is a system error log regarding a container build failure
  and does not contain help text or usage information for the tool 'bandwagon'.\n\n
  Tool homepage: https://github.com/Edinburgh-Genome-Foundry/bandwagon"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bandwagon:0.3.4--pyh7e72e81_0
stdout: bandwagon.out
