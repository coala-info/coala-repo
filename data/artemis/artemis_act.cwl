cwlVersion: v1.2
class: CommandLineTool
baseCommand: artemis_act
label: artemis_act
doc: "Artemis Comparison Tool (ACT) is a DNA sequence comparison viewer. (Note: The
  provided text contains system error logs rather than help documentation; no arguments
  could be extracted from the input).\n\nTool homepage: http://sanger-pathogens.github.io/Artemis/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/artemis:18.2.0--hdfd78af_0
stdout: artemis_act.out
