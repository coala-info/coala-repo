cwlVersion: v1.2
class: CommandLineTool
baseCommand: progressivecactus
label: progressivecactus
doc: "The provided text does not contain help information or a description of the
  tool; it contains container runtime log messages indicating a failure to fetch the
  OCI image.\n\nTool homepage: https://github.com/glennhickey/progressiveCactus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/progressivecactus:0.1
stdout: progressivecactus.out
