cwlVersion: v1.2
class: CommandLineTool
baseCommand: printsextract
label: emboss_printsextract
doc: Extract data from PRINTS database for use by pscan
inputs:
  - id: infile
    type: File
    doc: PRINTS database file
    inputBinding:
      position: 101
      prefix: -infile
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emboss:6.6.0--h0f19ade_14
stdout: printsextract.out
s:url: http://emboss.open-bio.org/
$namespaces:
  s: https://schema.org/
