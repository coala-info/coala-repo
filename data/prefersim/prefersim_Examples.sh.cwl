cwlVersion: v1.2
class: CommandLineTool
baseCommand: prefersim_Examples.sh
label: prefersim_Examples.sh
doc: "A script to run examples for the prefersim tool. (Note: The provided text contains
  container runtime error logs rather than command-line help documentation, so no
  arguments could be extracted.)\n\nTool homepage: https://github.com/LohmuellerLab/PReFerSim"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prefersim:1.0--h940b034_4
stdout: prefersim_Examples.sh.out
