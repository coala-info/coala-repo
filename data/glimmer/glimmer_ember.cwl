cwlVersion: v1.2
class: CommandLineTool
baseCommand: glimmer_ember
label: glimmer_ember
doc: "Glimmer (Gene Locator and Interpolated Markov ModelER) is a system for finding
  genes in microbial DNA. (Note: The provided text is a container runtime error log
  and does not contain specific usage instructions or argument definitions).\n\nTool
  homepage: https://github.com/glimmerjs/glimmer-vm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/glimmer:3.02--2
stdout: glimmer_ember.out
