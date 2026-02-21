cwlVersion: v1.2
class: CommandLineTool
baseCommand: novae
label: novae
doc: "A tool for spatial transcriptomics analysis (Note: The provided text contains
  container runtime logs and error messages rather than command-line help documentation).\n
  \nTool homepage: https://mics-lab.github.io/novae/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/novae:1.0.2--pyhdfd78af_0
stdout: novae.out
