cwlVersion: v1.2
class: CommandLineTool
baseCommand: clustal-omega
label: clustal-omega
doc: "Clustal Omega is a general purpose multiple sequence alignment (MSA) program
  for proteins and DNA/RNA. (Note: The provided help text contains only system error
  logs and no command-line argument definitions).\n\nTool homepage: https://github.com/hybsearch/clustalo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/clustal-omega:v1.2.1-1_cv3
stdout: clustal-omega.out
