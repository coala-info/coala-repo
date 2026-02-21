cwlVersion: v1.2
class: CommandLineTool
baseCommand: centroid_fold
label: centroid_rna_package_centroid_fold
doc: "The provided text does not contain help information for the tool, but rather
  a system error log indicating a failure to build or extract the container image
  due to lack of disk space.\n\nTool homepage: https://github.com/satoken/centroid-rna-package"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/centroid_rna_package:0.0.16--0
stdout: centroid_rna_package_centroid_fold.out
