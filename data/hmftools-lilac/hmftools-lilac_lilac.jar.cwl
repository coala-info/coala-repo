cwlVersion: v1.2
class: CommandLineTool
baseCommand: lilac
label: hmftools-lilac_lilac.jar
doc: "Lilac is a tool for HLA typing and somatic mutation detection in HLA genes.\n
  \nTool homepage: https://github.com/hartwigmedical/hmftools/blob/master/lilac/README.md"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmftools-lilac:1.7.3--hdfd78af_0
stdout: hmftools-lilac_lilac.jar.out
