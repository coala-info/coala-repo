cwlVersion: v1.2
class: CommandLineTool
baseCommand: centroid_rna_package
label: centroid_rna_package
doc: "Centroid-based RNA secondary structure prediction package. (Note: The provided
  input text consists of container runtime error logs and does not contain usage instructions
  or argument definitions.)\n\nTool homepage: https://github.com/satoken/centroid-rna-package"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/centroid_rna_package:0.0.16--0
stdout: centroid_rna_package.out
