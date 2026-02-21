cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - niemagraphgen
  - ngg_ring_lattice
label: niemagraphgen_ngg_ring_lattice
doc: "A tool for generating ring lattice graphs. (Note: The provided text contains
  system error messages regarding a container execution failure and does not contain
  the actual help documentation or argument definitions).\n\nTool homepage: https://github.com/niemasd/NiemaGraphGen"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/niemagraphgen:1.0.6--h503566f_1
stdout: niemagraphgen_ngg_ring_lattice.out
