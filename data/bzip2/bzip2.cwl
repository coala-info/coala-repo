cwlVersion: v1.2
class: CommandLineTool
baseCommand: bzip2
label: bzip2
doc: "The provided text is an error log indicating a system failure (no space left
  on device) while attempting to pull a container image and does not contain help
  text or usage information for the tool.\n\nTool homepage: https://github.com/icsharpcode/SharpZipLib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bzip2:1.0.8--2
stdout: bzip2.out
