cwlVersion: v1.2
class: CommandLineTool
baseCommand: gimmemotifs
label: gimmemotifs
doc: "A suite of tools for motif analysis. (Note: The provided input text contains
  container runtime error messages and does not include help documentation or argument
  definitions.)\n\nTool homepage: https://github.com/vanheeringen-lab/gimmemotifs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gimmemotifs:0.18.1--h9ee0642_0
stdout: gimmemotifs.out
