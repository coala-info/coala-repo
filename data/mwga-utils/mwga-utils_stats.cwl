cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mwga-utils
  - stats
label: mwga-utils_stats
doc: "The provided text does not contain help information or usage instructions; it
  contains container runtime log messages and a fatal error regarding disk space.\n
  \nTool homepage: https://github.com/RomainFeron/mgwa_utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mwga-utils:0.1.6--h9948957_3
stdout: mwga-utils_stats.out
