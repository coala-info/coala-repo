cwlVersion: v1.2
class: CommandLineTool
baseCommand: metapi
label: metapi
doc: "A metagenomic analysis pipeline. (Note: The provided help text contains only
  system error logs and no command-line usage information.)\n\nTool homepage: https://github.com/ohmeta/metapi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metapi:3.0.0--pyhdfd78af_0
stdout: metapi.out
