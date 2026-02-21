cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaprokka_get-phrogs
label: metaprokka_get-phrogs
doc: "A tool to retrieve PHROGs (Prokaryotic Virus Remote Homologous Groups) data
  for MetaProkka. Note: The provided help text contains only system error messages
  regarding container execution and does not list specific command-line arguments.\n
  \nTool homepage: https://github.com/telatin/metaprokka"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaprokka:1.15.0--pl5321hdfd78af_0
stdout: metaprokka_get-phrogs.out
