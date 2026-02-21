cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyloaln
label: phyloaln
doc: "The provided text does not contain help information or usage instructions for
  the tool; it is a log of a container build failure.\n\nTool homepage: https://github.com/huangyh45/PhyloAln"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyloaln:1.1.0--hdfd78af_0
stdout: phyloaln.out
