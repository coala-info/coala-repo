cwlVersion: v1.2
class: CommandLineTool
baseCommand: get_homologues-est.pl
label: get_homologues_get_homologues-est.pl
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding container image building (no space
  left on device).\n\nTool homepage: https://github.com/eead-csic-compbio/get_homologues"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/get_fasta_info:2.5.0--h577a1d6_0
stdout: get_homologues_get_homologues-est.pl.out
