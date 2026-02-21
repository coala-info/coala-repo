cwlVersion: v1.2
class: CommandLineTool
baseCommand: fa-lint
label: fa-lint
doc: "A tool for linting FASTA files (Note: The provided text contains only system
  error messages and no usage information).\n\nTool homepage: https://github.com/GallVp/fa-lint"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fa-lint:1.2.0--he881be0_0
stdout: fa-lint.out
