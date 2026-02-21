cwlVersion: v1.2
class: CommandLineTool
baseCommand: centroid_alifold
label: centroid_rna_package_centroid_alifold
doc: "Centroid-based RNA secondary structure prediction from alignments (Note: The
  provided help text contains a system error and does not list arguments).\n\nTool
  homepage: https://github.com/satoken/centroid-rna-package"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/centroid_rna_package:0.0.16--0
stdout: centroid_rna_package_centroid_alifold.out
