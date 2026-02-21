cwlVersion: v1.2
class: CommandLineTool
baseCommand: mimodd
label: mimodd
doc: "MiModD is a comprehensive software package for the identification of causing
  mutations in model organisms from whole-genome sequencing data.\n\nTool homepage:
  http://sourceforge.net/projects/mimodd"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimodd:0.1.9--py35_0
stdout: mimodd.out
