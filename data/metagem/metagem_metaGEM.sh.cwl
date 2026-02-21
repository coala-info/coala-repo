cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaGEM.sh
label: metagem_metaGEM.sh
doc: "A tool for metagenomic data analysis (Note: The provided help text contains
  only system error logs and no usage information).\n\nTool homepage: https://github.com/franciscozorrilla/metaGEM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metagem:1.0.5--hdfd78af_0
stdout: metagem_metaGEM.sh.out
