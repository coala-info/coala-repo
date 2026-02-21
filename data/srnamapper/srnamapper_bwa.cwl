cwlVersion: v1.2
class: CommandLineTool
baseCommand: srnamapper_bwa
label: srnamapper_bwa
doc: "sRNAmapper (Note: The provided text contains container build logs and error
  messages rather than CLI help documentation. No arguments could be extracted.)\n
  \nTool homepage: https://github.com/mzytnicki/srnaMapper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/srnamapper:1.0.12--h577a1d6_0
stdout: srnamapper_bwa.out
