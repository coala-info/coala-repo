cwlVersion: v1.2
class: CommandLineTool
baseCommand: milonga
label: milonga
doc: "A tool for long-read assembly of viral genomes (Note: The provided help text
  contains only system error logs and no usage information).\n\nTool homepage: https://gitlab.com/bfr_bioinformatics/milonga"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/milonga:1.0.3--hdfd78af_0
stdout: milonga.out
