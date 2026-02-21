cwlVersion: v1.2
class: CommandLineTool
baseCommand: vamb
label: vamb
doc: "VAMB: Variational Autoencoders for Metagenomic Binning (Note: The provided text
  is a container build error log and does not contain help information. No arguments
  could be extracted.)\n\nTool homepage: https://github.com/RasmussenLab/vamb"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vamb:5.0.4--pyhdfd78af_0
stdout: vamb.out
