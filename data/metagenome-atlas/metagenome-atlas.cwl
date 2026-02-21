cwlVersion: v1.2
class: CommandLineTool
baseCommand: metagenome-atlas
label: metagenome-atlas
doc: "Metagenome-atlas is a tool for metagenome analysis. (Note: The provided text
  contains container execution logs and error messages rather than help documentation;
  therefore, no arguments could be extracted.)\n\nTool homepage: https://github.com/metagenome-atlas"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metagenome-atlas:19.0.1--pyhdfd78af_0
stdout: metagenome-atlas.out
