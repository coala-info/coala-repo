cwlVersion: v1.2
class: CommandLineTool
baseCommand: art
label: artemis_art
doc: "Artemis is a free genome browser and annotation tool that allows visualization
  of sequence features, next generation sequencing data and the results of analyses
  within the context of the sequence, and also its six-frame translation.\n\nTool
  homepage: http://sanger-pathogens.github.io/Artemis/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/artemis:18.2.0--hdfd78af_0
stdout: artemis_art.out
