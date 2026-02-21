cwlVersion: v1.2
class: CommandLineTool
baseCommand: eastr-cpp
label: eastr_eastr-cpp
doc: "EASTR (Emendation of Alignment of Spliced Tenacious Reads) - A tool for detecting
  and removing artifacts in spliced alignments.\n\nTool homepage: https://github.com/ishinder/EASTR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eastr:1.1.2--py311h2de2dd3_1
stdout: eastr_eastr-cpp.out
