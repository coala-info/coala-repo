cwlVersion: v1.2
class: CommandLineTool
baseCommand: phylodeep_data_bd
label: phylodeep_data_bd
doc: "PhyloDeep data BD (Birth-Death) processing tool. (Note: The provided text contains
  container build logs rather than command-line help documentation, so specific arguments
  could not be extracted.)\n\nTool homepage: https://github.com/evolbioinfo/phylodeep_data_bd"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylodeep_data_bd:0.6--pyhdfd78af_0
stdout: phylodeep_data_bd.out
