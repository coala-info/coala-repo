cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastmd5
label: fastmd5
doc: "A tool for fast MD5 checksum calculation. (Note: The provided input text appears
  to be a container runtime error log rather than help text, so no specific arguments
  could be extracted.)\n\nTool homepage: https://github.com/moold/fastMD5"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastmd5:1.0.0--h3ab6199_0
stdout: fastmd5.out
