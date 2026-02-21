cwlVersion: v1.2
class: CommandLineTool
baseCommand: phylodeep_checkdeep
label: phylodeep_checkdeep
doc: "A tool to check the installation and availability of deep learning models for
  PhyloDeep.\n\nTool homepage: https://github.com/evolbioinfo/phylodeep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylodeep:0.9--pyhdfd78af_0
stdout: phylodeep_checkdeep.out
