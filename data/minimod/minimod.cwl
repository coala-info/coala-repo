cwlVersion: v1.2
class: CommandLineTool
baseCommand: minimod
label: minimod
doc: "The provided text is an error log from a container runtime and does not contain
  help information or usage instructions for the tool 'minimod'.\n\nTool homepage:
  https://github.com/warp9seq/minimod"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minimod:0.4.0--h577a1d6_0
stdout: minimod.out
