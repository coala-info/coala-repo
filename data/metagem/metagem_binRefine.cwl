cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metagem
  - binRefine
label: metagem_binRefine
doc: "A tool for metagenomic bin refinement. (Note: The provided help text contains
  only container execution error logs and does not list command-line arguments.)\n
  \nTool homepage: https://github.com/franciscozorrilla/metaGEM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metagem:1.0.5--hdfd78af_0
stdout: metagem_binRefine.out
