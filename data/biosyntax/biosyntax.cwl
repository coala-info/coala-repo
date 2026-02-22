cwlVersion: v1.2
class: CommandLineTool
baseCommand: biosyntax
label: biosyntax
doc: "The provided text contains system error messages related to a Singularity/Docker
  container pull failure ('no space left on device') and does not contain CLI help
  documentation or argument definitions.\n\nTool homepage: https://github.com/bioSyntax/bioSyntax"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/biosyntax:v1.0.0b-1-deb_cv1
stdout: biosyntax.out
