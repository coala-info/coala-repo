cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdk-inchi-to-svg
label: cdk-inchi-to-svg
doc: "A tool to convert InChI strings to SVG images. Note: The provided help text
  contains only system error messages regarding a container build failure and does
  not list specific command-line arguments.\n\nTool homepage: https://github.com/ipb-halle/cdk-inchi-to-svg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cdk-inchi-to-svg:0.9--hdfd78af_1
stdout: cdk-inchi-to-svg.out
