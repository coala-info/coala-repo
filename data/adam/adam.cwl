cwlVersion: v1.2
class: CommandLineTool
baseCommand: adam
label: adam
doc: "ADAM is a genomics analysis platform and command line toolset built on Apache
  Spark.\n\nTool homepage: https://github.com/bigdatagenomics/adam"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/adam:1.0.1--hdfd78af_0
stdout: adam.out
