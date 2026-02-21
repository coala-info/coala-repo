cwlVersion: v1.2
class: CommandLineTool
baseCommand: saffrontree
label: saffrontree
doc: "A tool for fast and scalable neighbor-joining phylogeny. (Note: The provided
  text contains container build logs and error messages rather than the tool's help
  documentation; therefore, no arguments could be extracted.)\n\nTool homepage: https://github.com/sanger-pathogens/saffrontree"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/saffrontree:0.1.2--pyhdfd78af_2
stdout: saffrontree.out
