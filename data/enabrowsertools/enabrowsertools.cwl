cwlVersion: v1.2
class: CommandLineTool
baseCommand: enabrowsertools
label: enabrowsertools
doc: "The ENA Browser Tools are a set of command-line tools to download data from
  the European Nucleotide Archive (ENA).\n\nTool homepage: https://github.com/enasequence/enaBrowserTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enabrowsertools:1.7.2--hdfd78af_0
stdout: enabrowsertools.out
