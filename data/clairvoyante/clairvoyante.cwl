cwlVersion: v1.2
class: CommandLineTool
baseCommand: clairvoyante
label: clairvoyante
doc: "A tool for variant calling (Note: The provided text contains only system logs
  and error messages regarding a container build failure, not the actual help documentation
  for the tool. No arguments could be extracted from the provided text.)\n\nTool homepage:
  https://github.com/aquaskyline/Clairvoyante"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clairvoyante:1.02--0
stdout: clairvoyante.out
