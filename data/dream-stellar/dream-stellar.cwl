cwlVersion: v1.2
class: CommandLineTool
baseCommand: dream-stellar
label: dream-stellar
doc: "A tool for distributed and error-aware metagenomic read alignment (Note: The
  provided help text contains only container runtime error messages and does not list
  specific command-line arguments).\n\nTool homepage: https://github.com/seqan/dream-stellar"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dream-stellar:2.1.0--haf24da9_0
stdout: dream-stellar.out
