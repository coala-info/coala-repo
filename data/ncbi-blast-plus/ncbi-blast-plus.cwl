cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncbi-blast-plus
label: ncbi-blast-plus
doc: "The provided text is a system error log indicating a failure to pull or build
  the container image (no space left on device) and does not contain the help text
  or usage instructions for the tool.\n\nTool homepage: https://github.com/ncbi/blast_plus_docs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ncbi-blast-plus:v2.8.1-1-deb_cv1
stdout: ncbi-blast-plus.out
