cwlVersion: v1.2
class: CommandLineTool
baseCommand: get_mnv
label: get_mnv
doc: "The provided text does not contain help information for the tool; it contains
  system log messages and a fatal error regarding container image acquisition.\n\n
  Tool homepage: https://github.com/PathoGenOmics-Lab/get_mnv"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/get_fasta_info:2.5.0--h577a1d6_0
stdout: get_mnv.out
