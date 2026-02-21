cwlVersion: v1.2
class: CommandLineTool
baseCommand: stereogene
label: stereogene
doc: "StereoGene is a tool for rapid estimation of genome-wide correlations among
  genomic features.\n\nTool homepage: http://stereogene.bioinf.fbb.msu.ru"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stereogene:2.20--h503566f_8
stdout: stereogene.out
