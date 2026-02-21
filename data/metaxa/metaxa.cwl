cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaxa
label: metaxa
doc: "Metaxa is a tool for automated detection and classification of ribosomal RNA
  sequences (Note: The provided text is a system error message and does not contain
  help documentation or argument details).\n\nTool homepage: http://microbiology.se/software/metaxa2/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaxa:2.2.3--pl5321hdfd78af_2
stdout: metaxa.out
