cwlVersion: v1.2
class: CommandLineTool
baseCommand: zpca
label: zpca
doc: "Zero-Phase Component Analysis tool (Note: The provided text is a container build
  error log and does not contain help documentation or argument definitions).\n\n
  Tool homepage: The package home page"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zpca:0.8.3.post1--pyh5e36f6f_0
stdout: zpca.out
