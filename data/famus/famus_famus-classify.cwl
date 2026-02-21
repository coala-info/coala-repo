cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - famus
  - classify
label: famus_famus-classify
doc: "Functional Annotation of Metagenomic Unassembled Sequences - classify subcommand\n
  \nTool homepage: https://github.com/burstein-lab/famus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/famus:0.2.2--py312hdfd78af_0
stdout: famus_famus-classify.out
