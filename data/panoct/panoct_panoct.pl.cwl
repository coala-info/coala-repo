cwlVersion: v1.2
class: CommandLineTool
baseCommand: panoct_panoct.pl
label: panoct_panoct.pl
doc: "PanOCT (Pangenome Ortholog Clustering Tool) - A tool for pangenome analysis
  and ortholog clustering.\n\nTool homepage: https://panoct.sourceforge.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panoct:3.23--pl5321hdfd78af_2
stdout: panoct_panoct.pl.out
