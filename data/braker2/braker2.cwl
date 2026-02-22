cwlVersion: v1.2
class: CommandLineTool
baseCommand: braker.pl
label: braker2
doc: "BRAKER is a pipeline for fully automated prediction of gene structures with
  GeneMark-EX and AUGUSTUS in novel eukaryotic genomes. (Note: The provided text contains
  system error messages and does not include help documentation; therefore, no arguments
  could be extracted.)\n\nTool homepage: https://github.com/Gaius-Augustus/BRAKER"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/braker2:2.1.6--hdfd78af_5
stdout: braker2.out
