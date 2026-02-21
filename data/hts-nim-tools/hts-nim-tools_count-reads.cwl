cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hts-nim-tools
  - count-reads
label: hts-nim-tools_count-reads
doc: "The provided text does not contain help information for the tool, as it consists
  of system error messages regarding container image building and disk space issues.\n
  \nTool homepage: https://github.com/brentp/hts-nim-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hts-nim-tools:0.3.11--hbeb723e_0
stdout: hts-nim-tools_count-reads.out
