cwlVersion: v1.2
class: CommandLineTool
baseCommand: phylip
label: phylip
doc: "PHYLIP (the PHYLogeny Inference Package) is a package of programs for inferring
  phylogenies. Note: The provided text appears to be a container runtime error log
  rather than help text, so no arguments could be extracted.\n\nTool homepage: http://evolution.genetics.washington.edu/phylip/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylip:3.697--h470a237_0
stdout: phylip.out
