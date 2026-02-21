cwlVersion: v1.2
class: CommandLineTool
baseCommand: adun-core
label: adun-core
doc: "Adun is a molecular simulation program. (Note: The provided text contains system
  error logs rather than help documentation; no arguments could be extracted from
  the input.)\n\nTool homepage: https://github.com/ngtnraoaeacrhrp/adunit-core-id-4159386720"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/adun-core:v0.81-13-deb_cv1
stdout: adun-core.out
