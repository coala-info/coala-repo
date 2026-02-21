cwlVersion: v1.2
class: CommandLineTool
baseCommand: jacusa2
label: jacusa2_jacusa2.jar
doc: "JACUSA2 (Java-based Annotator for Cleavage and Unmetabolized Site Analysis)
  is a tool for detecting site-specific variants in RNA-seq data. Note: The provided
  text contains system error messages regarding container image building and does
  not list command-line arguments.\n\nTool homepage: https://github.com/dieterich-lab/JACUSA2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jacusa2:2.1.16--hdfd78af_0
stdout: jacusa2_jacusa2.jar.out
