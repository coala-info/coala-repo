cwlVersion: v1.2
class: CommandLineTool
baseCommand: snoscan
label: snoscan
doc: "A tool for searching for C/D box methylation guide snoRNA genes in genomic sequences.\n
  \nTool homepage: http://lowelab.ucsc.edu/snoscan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snoscan:1.0--pl5321h031d066_5
stdout: snoscan.out
