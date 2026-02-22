cwlVersion: v1.2
class: CommandLineTool
baseCommand: crispr_studio
label: crispr_studio
doc: "CRISPR Studio is a tool for visualizing CRISPR-Cas9 screens. (Note: The provided
  text is a system error log and does not contain command-line argument definitions.)\n\
  \nTool homepage: https://github.com/moineaulab/CRISPRStudio"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crispr_studio:1--1
stdout: crispr_studio.out
