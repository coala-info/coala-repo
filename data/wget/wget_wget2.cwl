cwlVersion: v1.2
class: CommandLineTool
baseCommand: wget
label: wget_wget2
doc: "The provided text appears to be a container build log error rather than CLI
  help text. No arguments or descriptions could be extracted from the input.\n\nTool
  homepage: https://github.com/rockdaboot/wget2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wget:1.25.0
stdout: wget_wget2.out
