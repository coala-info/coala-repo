cwlVersion: v1.2
class: CommandLineTool
baseCommand: mea_mea_mix
label: mea_mea_mix
doc: "A tool for Multiple Epigenome Analysis (MEA). Note: The provided help text contains
  only system error messages regarding container image building and does not list
  specific command-line arguments.\n\nTool homepage: http://www.bioinf.uni-leipzig.de/Software/mea/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mea:0.6.4--h9948957_10
stdout: mea_mea_mix.out
