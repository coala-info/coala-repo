cwlVersion: v1.2
class: CommandLineTool
baseCommand: merqury
label: merqury
doc: "A k-mer based tool for genome assembly evaluation (Note: The provided help text
  contains only system error messages and no usage information).\n\nTool homepage:
  https://github.com/marbl/merqury"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merqury:1.3--hdfd78af_4
stdout: merqury.out
