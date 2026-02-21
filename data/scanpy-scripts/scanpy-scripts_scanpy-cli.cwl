cwlVersion: v1.2
class: CommandLineTool
baseCommand: scanpy-cli
label: scanpy-scripts_scanpy-cli
doc: "Scanpy command line interface (Note: The provided text contains build logs rather
  than help text, so no arguments could be extracted).\n\nTool homepage: https://github.com/ebi-gene-expression-group/scanpy-scripts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
stdout: scanpy-scripts_scanpy-cli.out
