cwlVersion: v1.2
class: CommandLineTool
baseCommand: satrap
label: satrap
doc: "The provided text does not contain help information for the tool 'satrap'. It
  appears to be a log of a failed container image retrieval or build process.\n\n
  Tool homepage: http://satrap.cribi.unipd.it/cgi-bin/satrap.pl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/satrap:0.2--h9948957_7
stdout: satrap.out
