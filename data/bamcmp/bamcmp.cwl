cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamcmp
label: bamcmp
doc: "A tool for comparing BAM files (Note: The provided text is an error log from
  a container build process and does not contain help documentation or argument details).\n
  \nTool homepage: https://github.com/CRUKMI-ComputationalBiology/bamcmp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamcmp:2.2--h1cd46f9_1
stdout: bamcmp.out
