cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - atlas
label: mykatlas_atlas
doc: "Mykrobe Atlas: Rapid antibiotic resistance prediction from NGS data\n\nTool
  homepage: http://github.com/phelimb/atlas"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mykatlas:0.6.1--py39hdff8610_8
stdout: mykatlas_atlas.out
