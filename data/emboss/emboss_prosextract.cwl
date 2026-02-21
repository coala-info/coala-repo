cwlVersion: v1.2
class: CommandLineTool
baseCommand: prosextract
label: emboss_prosextract
doc: "Builds the PROSITE motif database for use by pscan. Note: The provided input
  text contains system error messages rather than tool help documentation; therefore,
  no arguments could be extracted from the source text.\n\nTool homepage: http://emboss.open-bio.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emboss:6.6.0--h0f19ade_14
stdout: emboss_prosextract.out
