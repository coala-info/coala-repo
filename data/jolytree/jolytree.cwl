cwlVersion: v1.2
class: CommandLineTool
baseCommand: jolytree
label: jolytree
doc: "JolyTree is a tool for alignment-free phylogeny reconstruction. (Note: The provided
  text contains container runtime errors and does not include the standard help documentation
  or usage instructions.)\n\nTool homepage: https://research.pasteur.fr/fr/software/jolytree/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jolytree:2.1--hdfd78af_0
stdout: jolytree.out
