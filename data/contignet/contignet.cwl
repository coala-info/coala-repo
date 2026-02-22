cwlVersion: v1.2
class: CommandLineTool
baseCommand: contignet
label: contignet
doc: "A tool for contig-level network analysis (Note: The provided text appears to
  be a system error log regarding disk space and container pulling rather than help
  text; therefore, no arguments could be extracted).\n\nTool homepage: https://github.com/tianqitang1/ContigNet"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/contignet:1.0.1.post3--pyh7cba7a3_0
stdout: contignet.out
