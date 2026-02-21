cwlVersion: v1.2
class: CommandLineTool
baseCommand: blacklist
label: encode-blacklist_Blacklist
doc: "The ENCODE Blacklist tool is used to identify and filter regions of the genome
  that often produce unreliable or problematic signals in high-throughput sequencing
  experiments.\n\nTool homepage: https://github.com/Boyle-Lab/Blacklist"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/encode-blacklist:2.0--ha7703dc_3
stdout: encode-blacklist_Blacklist.out
