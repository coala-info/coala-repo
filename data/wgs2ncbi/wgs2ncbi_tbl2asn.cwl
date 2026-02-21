cwlVersion: v1.2
class: CommandLineTool
baseCommand: wgs2ncbi_tbl2asn
label: wgs2ncbi_tbl2asn
doc: "A tool for preparing Whole Genome Shotgun (WGS) submissions for NCBI using tbl2asn.\n
  \nTool homepage: https://github.com/naturalis/wgs2ncbi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wgs2ncbi:1.1.2--pl526_0
stdout: wgs2ncbi_tbl2asn.out
