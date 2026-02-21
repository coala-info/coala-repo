cwlVersion: v1.2
class: CommandLineTool
baseCommand: dropletutils-empty-drops.R
label: dropletutils-scripts_dropletutils-empty-drops.R
doc: "Identify empty droplets in droplet-based single-cell RNA-seq data (Note: The
  provided help text contains only container execution errors and no argument information).\n
  \nTool homepage: https://github.com/ebi-gene-expression-group/dropletutils-scripts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dropletutils-scripts:0.0.5--hdfd78af_1
stdout: dropletutils-scripts_dropletutils-empty-drops.R.out
