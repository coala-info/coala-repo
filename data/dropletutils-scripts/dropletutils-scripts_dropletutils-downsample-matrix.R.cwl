cwlVersion: v1.2
class: CommandLineTool
baseCommand: dropletutils-downsample-matrix.R
label: dropletutils-scripts_dropletutils-downsample-matrix.R
doc: "Downsample a count matrix from droplet-based single-cell RNA-seq data.\n\nTool
  homepage: https://github.com/ebi-gene-expression-group/dropletutils-scripts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dropletutils-scripts:0.0.5--hdfd78af_1
stdout: dropletutils-scripts_dropletutils-downsample-matrix.R.out
