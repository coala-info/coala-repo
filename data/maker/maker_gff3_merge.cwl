cwlVersion: v1.2
class: CommandLineTool
baseCommand: maker_gff3_merge
label: maker_gff3_merge
doc: "A tool to merge GFF3 files produced by the MAKER annotation pipeline.\n\nTool
  homepage: http://www.yandell-lab.org/software/maker.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/maker:3.01.04--pl5321h7b50bb2_0
stdout: maker_gff3_merge.out
