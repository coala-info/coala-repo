cwlVersion: v1.2
class: CommandLineTool
baseCommand: sbml2sbol
label: sbml2sbol
doc: "A tool for converting SBML (Systems Biology Markup Language) designs to SBOL
  (Synthetic Biology Open Language).\n\nTool homepage: https://github.com/conda-forge/sbml2sbol-feedstock"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sbml2sbol:0.1.13
stdout: sbml2sbol.out
