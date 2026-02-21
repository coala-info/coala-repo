cwlVersion: v1.2
class: CommandLineTool
baseCommand: faqcs
label: faqcs
doc: "FaQCs: A Quality Control Tool for Next Generation Sequencing Data (Note: The
  provided text contains container runtime error messages rather than tool help text,
  so no arguments could be extracted).\n\nTool homepage: https://github.com/LANL-Bioinformatics/FaQCs/releases"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/faqcs:2.12--r44h077b44d_0
stdout: faqcs.out
