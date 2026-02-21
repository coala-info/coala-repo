cwlVersion: v1.2
class: CommandLineTool
baseCommand: phabox
label: phabox
doc: "PhaBOX: a tool for phage host prediction and analysis. Note: The provided input
  text appears to be a container execution error log (no space left on device) rather
  than the tool's help documentation, so no arguments could be extracted.\n\nTool
  homepage: https://github.com/KennthShang/PhaBOX"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phabox:2.1.13--pyhdfd78af_0
stdout: phabox.out
