cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigwig-nim_bigwig
label: bigwig-nim_bigwig
doc: "view and convert bigwig\n\nTool homepage: https://github.com/brentp/bigwig-nim"
inputs:
  - id: stats
    type:
      - 'null'
      - boolean
    doc: extract stats (coverage a gnotate zip file for a given VCF
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bigwig-nim:0.0.3--h9ee0642_0
stdout: bigwig-nim_bigwig.out
