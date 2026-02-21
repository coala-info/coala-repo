cwlVersion: v1.2
class: CommandLineTool
baseCommand: varvamp
label: varvamp
doc: "A tool for variant analysis (Note: The provided text contains build logs rather
  than help documentation, so specific arguments could not be extracted).\n\nTool
  homepage: https://github.com/jonas-fuchs/varVAMP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varvamp:1.3--pyhdfd78af_0
stdout: varvamp.out
