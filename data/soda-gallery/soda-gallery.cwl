cwlVersion: v1.2
class: CommandLineTool
baseCommand: soda-gallery
label: soda-gallery
doc: "A tool for visualizing genomic data (Note: The provided text contains container
  build logs and error messages rather than standard CLI help text, so no arguments
  could be extracted).\n\nTool homepage: https://github.com/alexpreynolds/soda"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/soda-gallery:1.2.0--pyhdfd78af_0
stdout: soda-gallery.out
