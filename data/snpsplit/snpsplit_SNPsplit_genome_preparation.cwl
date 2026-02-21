cwlVersion: v1.2
class: CommandLineTool
baseCommand: SNPsplit_genome_preparation
label: snpsplit_SNPsplit_genome_preparation
doc: "Genome preparation for SNPsplit. Note: The provided help text contains only
  container runtime logs and error messages, so no specific arguments could be extracted.\n
  \nTool homepage: https://www.bioinformatics.babraham.ac.uk/projects/SNPsplit/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snpsplit:0.6.0--hdfd78af_0
stdout: snpsplit_SNPsplit_genome_preparation.out
