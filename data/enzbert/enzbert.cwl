cwlVersion: v1.2
class: CommandLineTool
baseCommand: enzbert
label: enzbert
doc: "EnzBERT: A tool for enzyme-related tasks using BERT models (Note: The provided
  text contains only container runtime error logs and no help documentation).\n\n
  Tool homepage: https://gitlab.inria.fr/nbuton/tfpc/-/tree/EnzBert_conda"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enzbert:1.1--pyh7e72e81_0
stdout: enzbert.out
