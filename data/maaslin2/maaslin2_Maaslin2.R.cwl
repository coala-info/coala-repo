cwlVersion: v1.2
class: CommandLineTool
baseCommand: Maaslin2.R
label: maaslin2_Maaslin2.R
doc: "MaAsLin2 is a comprehensive R package for efficiently determining associations
  between clinical metadata and microbial community abundance.\n\nTool homepage: http://huttenhower.sph.harvard.edu/maaslin2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/maaslin2:1.16.0--r43hdfd78af_0
stdout: maaslin2_Maaslin2.R.out
