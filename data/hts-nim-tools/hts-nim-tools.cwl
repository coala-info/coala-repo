cwlVersion: v1.2
class: CommandLineTool
baseCommand: hts-nim-tools
label: hts-nim-tools
doc: "The provided text does not contain help documentation. It consists of system
  error messages indicating a failure to build or run a container image due to insufficient
  disk space ('no space left on device').\n\nTool homepage: https://github.com/brentp/hts-nim-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hts-nim-tools:0.3.11--hbeb723e_0
stdout: hts-nim-tools.out
