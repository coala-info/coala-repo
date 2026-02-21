cwlVersion: v1.2
class: CommandLineTool
baseCommand: duet
label: duet
doc: "A tool for SNP-assisted signaling and haplotype-resolved assembly (Note: The
  provided text contains only system error logs and no help documentation; therefore,
  no arguments could be extracted).\n\nTool homepage: https://github.com/yekaizhou/duet"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/duet:1.0--pyhdfd78af_0
stdout: duet.out
