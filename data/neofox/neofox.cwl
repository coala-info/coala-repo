cwlVersion: v1.2
class: CommandLineTool
baseCommand: neofox
label: neofox
doc: "Neoantigen Feature Optimizer and Explorer (Note: The provided text is a runtime
  error log and does not contain help documentation or argument definitions).\n\n
  Tool homepage: https://github.com/tron-bioinformatics/neofox"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neofox:1.2.3--pyhdfd78af_0
stdout: neofox.out
