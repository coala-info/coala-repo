cwlVersion: v1.2
class: CommandLineTool
baseCommand: metfrag-cli
label: metfrag-cli
doc: "MetFrag command-line interface for in silico fragmentation and metabolite identification.\n
  \nTool homepage: http://c-ruttkies.github.io/MetFrag/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/metfrag-cli:phenomenal-v2.4.5_cv0.4.28
stdout: metfrag-cli.out
