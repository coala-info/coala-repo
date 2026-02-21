cwlVersion: v1.2
class: CommandLineTool
baseCommand: hlso
label: haplotype-lso_hlso
doc: "Haplotype-LSO (Local Search Optimization) tool for haplotype assembly.\n\nTool
  homepage: https://github.com/holtgrewe/haplotype-lso"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haplotype-lso:0.4.4--pyhdfd78af_4
stdout: haplotype-lso_hlso.out
