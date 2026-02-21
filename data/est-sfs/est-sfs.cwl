cwlVersion: v1.2
class: CommandLineTool
baseCommand: est-sfs
label: est-sfs
doc: "Estimation of the site frequency spectrum (SFS) and ancestral states. (Note:
  The provided text contains container runtime errors and does not include usage instructions
  or argument definitions.)\n\nTool homepage: https://sourceforge.net/projects/est-usfs/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/est-sfs:2.04--h985cbd6_1
stdout: est-sfs.out
