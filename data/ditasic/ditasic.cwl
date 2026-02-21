cwlVersion: v1.2
class: CommandLineTool
baseCommand: ditasic
label: ditasic
doc: "Differential Abundance Table Similarity Correction. (Note: The provided text
  is a system error log indicating a failure to build the container image due to lack
  of disk space and does not contain the tool's help documentation.)\n\nTool homepage:
  https://rki_bioinformatics.gitlab.io/ditasic/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ditasic:0.2--py37h470a237_0
stdout: ditasic.out
