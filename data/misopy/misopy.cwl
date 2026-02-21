cwlVersion: v1.2
class: CommandLineTool
baseCommand: misopy
label: misopy
doc: "MISO (Mixture-of-Isoforms) is a probabilistic framework that quantitates the
  expression level of alternatively spliced genes from RNA-Seq data. Note: The provided
  text is a system error message regarding disk space and does not contain CLI help
  information.\n\nTool homepage: http://genes.mit.edu/burgelab/miso/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/misopy:0.5.4--py27h470a237_1
stdout: misopy.out
