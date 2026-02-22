cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pb-falconc
  - pbipa
label: pb-falconc_pbipa
doc: "PacBio Improved Phased Assembler (IPA). Note: The provided text contains system
  error messages regarding container execution and disk space rather than standard
  help documentation.\n\nTool homepage: https://github.com/PacificBiosciences/pbbioconda"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pb-falconc:1.15.0--h41535f3_3
stdout: pb-falconc_pbipa.out
