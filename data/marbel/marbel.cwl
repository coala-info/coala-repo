cwlVersion: v1.2
class: CommandLineTool
baseCommand: marbel
label: marbel
doc: "Metagenomic Assembly-based Binning and Evaluation Pipeline (Note: The provided
  text contains only container runtime error logs and no help documentation. No arguments
  could be extracted.)\n\nTool homepage: https://github.com/jlab/marbel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/marbel:0.2.4--pyh7e72e81_0
stdout: marbel.out
