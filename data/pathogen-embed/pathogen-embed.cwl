cwlVersion: v1.2
class: CommandLineTool
baseCommand: pathogen-embed
label: pathogen-embed
doc: "The provided text contains system error messages (disk space exhaustion) rather
  than the tool's help documentation. No command-line arguments or descriptions could
  be extracted.\n\nTool homepage: https://github.com/blab/pathogen-embed"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pathogen-embed:3.1.0--pyhdfd78af_0
stdout: pathogen-embed.out
