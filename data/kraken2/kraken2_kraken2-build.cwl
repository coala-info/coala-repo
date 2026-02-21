cwlVersion: v1.2
class: CommandLineTool
baseCommand: kraken2-build
label: kraken2_kraken2-build
doc: "The provided text does not contain help information for kraken2-build; it contains
  container runtime error messages regarding a lack of disk space.\n\nTool homepage:
  http://ccb.jhu.edu/software/kraken/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kraken2:2.17.1--pl5321h077b44d_0
stdout: kraken2_kraken2-build.out
