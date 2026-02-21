cwlVersion: v1.2
class: CommandLineTool
baseCommand: fingerprintscan
label: fingerprintscan
doc: "A tool for scanning protein sequences against the PRINTS database of protein
  fingerprints.\n\nTool homepage: https://github.com/ebi-pf-team/interproscan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fingerprintscan:3_597--h9948957_5
stdout: fingerprintscan.out
