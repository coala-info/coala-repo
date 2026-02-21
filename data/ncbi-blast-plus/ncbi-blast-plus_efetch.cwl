cwlVersion: v1.2
class: CommandLineTool
baseCommand: efetch
label: ncbi-blast-plus_efetch
doc: "The provided text does not contain help information for the tool; it contains
  a system error message regarding a container execution failure (no space left on
  device).\n\nTool homepage: https://github.com/ncbi/blast_plus_docs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ncbi-blast-plus:v2.8.1-1-deb_cv1
stdout: ncbi-blast-plus_efetch.out
