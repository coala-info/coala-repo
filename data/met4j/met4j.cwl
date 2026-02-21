cwlVersion: v1.2
class: CommandLineTool
baseCommand: met4j
label: met4j
doc: "Metabolic network analysis tool (Note: The provided text contains system error
  messages and does not include help documentation or argument definitions).\n\nTool
  homepage: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
stdout: met4j.out
