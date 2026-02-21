cwlVersion: v1.2
class: CommandLineTool
baseCommand: arch
label: coreutils_arch
doc: "Print system architecture\n\nTool homepage: https://github.com/uutils/coreutils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coreutils:9.5
stdout: coreutils_arch.out
