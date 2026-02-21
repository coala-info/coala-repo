cwlVersion: v1.2
class: CommandLineTool
baseCommand: miRDeep2.pl
label: mirdeep2_miRDeep2.pl
doc: "miRDeep2 is a tool for identifying known and novel miRNAs from deep sequencing
  data. (Note: The provided text contained system error messages rather than help
  text; no arguments could be extracted from the input.)\n\nTool homepage: https://www.mdc-berlin.de/8551903/en/research/research_teams/systems_biology_of_gene_regulatory_elements/projects/miRDeep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
stdout: mirdeep2_miRDeep2.pl.out
