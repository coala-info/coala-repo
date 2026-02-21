cwlVersion: v1.2
class: CommandLineTool
baseCommand: genomestrip
label: genomestrip
doc: "Genome STRiP (Discovery and genotyping of structural variation). Note: The provided
  text contains container runtime error logs rather than command-line help documentation.\n
  \nTool homepage: http://software.broadinstitute.org/software/genomestrip/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomestrip:2.00.1833--1
stdout: genomestrip.out
