cwlVersion: v1.2
class: CommandLineTool
baseCommand: upimapi
label: upimapi
doc: "Universal Protein Resource (UniProt) Id Mapping API tool. (Note: The provided
  text contains container build logs and error messages rather than the tool's help
  documentation.)\n\nTool homepage: https://github.com/iquasere/UPIMAPI"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/upimapi:1.13.3--hdfd78af_0
stdout: upimapi.out
