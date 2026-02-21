cwlVersion: v1.2
class: CommandLineTool
baseCommand: phame
label: phame
doc: "Phylogenetic Analysis Tool for Molecular Evolution. (Note: The provided text
  is a system error log regarding a container build failure and does not contain CLI
  help information or argument definitions.)\n\nTool homepage: https://github.com/LANL-Bioinformatics/PhaME"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phame:1.0.3--0
stdout: phame.out
