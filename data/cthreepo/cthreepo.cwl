cwlVersion: v1.2
class: CommandLineTool
baseCommand: cthreepo
label: cthreepo
doc: "The provided text is an error log from a container build process and does not
  contain help text or usage information for the tool 'cthreepo'. As a result, no
  arguments could be extracted.\n\nTool homepage: https://github.com/vkkodali/cthreepo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cthreepo:0.1.3--pyh7cba7a3_0
stdout: cthreepo.out
