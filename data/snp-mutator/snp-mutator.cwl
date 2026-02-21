cwlVersion: v1.2
class: CommandLineTool
baseCommand: snp-mutator
label: snp-mutator
doc: "The provided text is a system error log regarding a container build failure
  and does not contain help information or usage instructions for the tool.\n\nTool
  homepage: https://github.com/CFSAN-Biostatistics/snp-mutator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snp-mutator:1.2.0--pyh24bf2e0_0
stdout: snp-mutator.out
