cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmerinshort
label: kmerinshort
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error messages related to a container runtime failure (no
  space left on device).\n\nTool homepage: https://github.com/rizkg/KmerInShort"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmerinshort:1.0.1--0
stdout: kmerinshort.out
