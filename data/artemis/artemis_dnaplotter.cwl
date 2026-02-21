cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnaplotter
label: artemis_dnaplotter
doc: "A tool for generating circular and linear plots of genomes (Note: The provided
  input text contains system error logs rather than help documentation; no arguments
  could be extracted).\n\nTool homepage: http://sanger-pathogens.github.io/Artemis/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/artemis:18.2.0--hdfd78af_0
stdout: artemis_dnaplotter.out
