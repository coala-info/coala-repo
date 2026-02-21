cwlVersion: v1.2
class: CommandLineTool
baseCommand: metagem
label: metagem
doc: "A tool for metagenomic analysis (Note: The provided text contains container
  runtime error logs rather than the tool's help documentation, so no arguments could
  be extracted).\n\nTool homepage: https://github.com/franciscozorrilla/metaGEM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metagem:1.0.5--hdfd78af_0
stdout: metagem.out
