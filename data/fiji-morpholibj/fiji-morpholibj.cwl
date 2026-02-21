cwlVersion: v1.2
class: CommandLineTool
baseCommand: fiji-morpholibj
label: fiji-morpholibj
doc: "MorphoLibJ is a collection of mathematical morphology methods and plugins for
  ImageJ/Fiji. Note: The provided help text contains only system error messages regarding
  a container build failure and does not list specific command-line arguments.\n\n
  Tool homepage: http://imagej.net/MorphoLibJ"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fiji-morpholibj:1.6.1--hdfd78af_0
stdout: fiji-morpholibj.out
