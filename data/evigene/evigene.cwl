cwlVersion: v1.2
class: CommandLineTool
baseCommand: evigene
label: evigene
doc: "Evidence-directed Gene construction (Note: The provided text contains container
  runtime error messages rather than tool help text).\n\nTool homepage: http://arthropods.eugenes.org/EvidentialGene/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/evigene:23.7.15--hdfd78af_1
stdout: evigene.out
