cwlVersion: v1.2
class: CommandLineTool
baseCommand: minipolish
label: minipolish
doc: "A tool for Racon polishing of miniasm assemblies. (Note: The provided text contains
  system error messages regarding container execution and does not include the standard
  help/usage documentation; therefore, no arguments could be extracted.)\n\nTool homepage:
  https://github.com/rrwick/Minipolish"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minipolish:0.2.0--pyhdfd78af_0
stdout: minipolish.out
