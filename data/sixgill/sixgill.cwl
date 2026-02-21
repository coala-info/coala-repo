cwlVersion: v1.2
class: CommandLineTool
baseCommand: sixgill
label: sixgill
doc: "Sixgill is a tool for protein-coding sequence discovery from shotgun metagenomic
  data. (Note: The provided text contains build logs rather than help documentation;
  no arguments could be extracted from the input.)\n\nTool homepage: https://github.com/ampledata/sixgill"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sixgill:0.2.4--py_3
stdout: sixgill.out
