cwlVersion: v1.2
class: CommandLineTool
baseCommand: jolytree_JolyTree.sh
label: jolytree_JolyTree.sh
doc: "JolyTree is a tool for alignment-free phylogenetics. (Note: The provided help
  text contains only system error messages regarding container execution and does
  not list specific tool arguments.)\n\nTool homepage: https://research.pasteur.fr/fr/software/jolytree/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jolytree:2.1--hdfd78af_0
stdout: jolytree_JolyTree.sh.out
