cwlVersion: v1.2
class: CommandLineTool
baseCommand: gimmemotifs-minimal
label: gimmemotifs-minimal
doc: "GimmeMotifs is a suite of tools for motif analysis. (Note: The provided text
  is a container runtime error message and does not contain CLI help documentation.)\n
  \nTool homepage: https://github.com/vanheeringen-lab/gimmemotifs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gimmemotifs-minimal:0.18.1--py39hbcbf7aa_0
stdout: gimmemotifs-minimal.out
