cwlVersion: v1.2
class: CommandLineTool
baseCommand: kingfisher
label: kingfisher
doc: "A tool for downloading and extracting sequence data and metadata from public
  repositories.\n\nTool homepage: https://github.com/wwood/kingfisher-download"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kingfisher:0.4.1--pyh7cba7a3_0
stdout: kingfisher.out
