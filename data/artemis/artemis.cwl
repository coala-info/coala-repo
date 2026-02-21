cwlVersion: v1.2
class: CommandLineTool
baseCommand: artemis
label: artemis
doc: "Artemis is a free genome browser and annotation tool that allows visualisation
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
stdout: artemis.out
