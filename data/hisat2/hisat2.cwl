cwlVersion: v1.2
class: CommandLineTool
baseCommand: hisat2
label: hisat2
doc: "HISAT2 is a fast and sensitive alignment program for mapping next-generation
  sequencing reads (both DNA and RNA) to a population of human genomes as well as
  to a single reference genome.\n\nTool homepage: http://daehwankimlab.github.io/hisat2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hisat2:2.2.2--h503566f_0
stdout: hisat2.out
