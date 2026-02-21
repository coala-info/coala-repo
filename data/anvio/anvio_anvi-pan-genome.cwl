cwlVersion: v1.2
class: CommandLineTool
baseCommand: anvi-pan-genome
label: anvio_anvi-pan-genome
doc: "The provided text is a container execution error log and does not contain help
  information or argument definitions for the tool.\n\nTool homepage: http://merenlab.org/software/anvio/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/anvio:7--hdfd78af_1
stdout: anvio_anvi-pan-genome.out
