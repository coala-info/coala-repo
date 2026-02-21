cwlVersion: v1.2
class: CommandLineTool
baseCommand: feelnc_FEELnc_codpot.pl
label: feelnc_FEELnc_codpot.pl
doc: "FEELnc_codpot is a module of the FEELnc (Flanking and Expression-based LncRNA
  annotation) pipeline used to compute the coding potential of transcripts.\n\nTool
  homepage: https://github.com/tderrien/FEELnc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/feelnc:0.2--pl526_0
stdout: feelnc_FEELnc_codpot.pl.out
