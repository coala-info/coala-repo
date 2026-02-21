cwlVersion: v1.2
class: CommandLineTool
baseCommand: fseq_mapviewToBed.pl
label: fseq_mapviewToBed.pl
doc: "A script to convert MapView format files to BED format. (Note: The provided
  text contains only system error messages and no usage information; therefore, no
  arguments could be extracted.)\n\nTool homepage: http://fureylab.web.unc.edu/software/fseq/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fseq:1.84--py35pl5.22.0_0
stdout: fseq_mapviewToBed.pl.out
