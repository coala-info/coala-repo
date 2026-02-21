cwlVersion: v1.2
class: CommandLineTool
baseCommand: dendropy-convert
label: dendropy_dendropy-convert
doc: "A tool for converting between phylogenetic tree and character data formats.
  (Note: The provided input text contains system error messages regarding container
  execution and does not include the standard help documentation or argument definitions.)\n
  \nTool homepage: https://github.com/jeetsukumaran/DendroPy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dendropy:5.0.8--pyhdfd78af_1
stdout: dendropy_dendropy-convert.out
