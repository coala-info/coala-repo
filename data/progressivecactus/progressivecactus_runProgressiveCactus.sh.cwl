cwlVersion: v1.2
class: CommandLineTool
baseCommand: progressivecactus_runProgressiveCactus.sh
label: progressivecactus_runProgressiveCactus.sh
doc: "The provided text does not contain help information or usage instructions; it
  is an error log from a failed container execution.\n\nTool homepage: https://github.com/glennhickey/progressiveCactus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/progressivecactus:0.1
stdout: progressivecactus_runProgressiveCactus.sh.out
