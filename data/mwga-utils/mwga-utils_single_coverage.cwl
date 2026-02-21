cwlVersion: v1.2
class: CommandLineTool
baseCommand: mwga-utils_single_coverage
label: mwga-utils_single_coverage
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding disk space during a container image
  pull.\n\nTool homepage: https://github.com/RomainFeron/mgwa_utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mwga-utils:0.1.6--h9948957_3
stdout: mwga-utils_single_coverage.out
