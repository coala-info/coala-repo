cwlVersion: v1.2
class: CommandLineTool
baseCommand: sonicparanoid
label: sonicparanoid
doc: "\nTool homepage: http://iwasakilab.bs.s.u-tokyo.ac.jp/sonicparanoid/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sonicparanoid:2.0.9--py312hc9302aa_0
stdout: sonicparanoid.out
