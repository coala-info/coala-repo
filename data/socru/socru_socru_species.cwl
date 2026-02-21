cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - socru
  - species
label: socru_socru_species
doc: "The provided text contains container runtime logs and a fatal error rather than
  the tool's help documentation. No arguments could be extracted.\n\nTool homepage:
  https://github.com/quadram-institute-bioscience/socru"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/socru:2.2.5--pyhdfd78af_0
stdout: socru_socru_species.out
