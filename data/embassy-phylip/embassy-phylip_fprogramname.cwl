cwlVersion: v1.2
class: CommandLineTool
baseCommand: fprogramname
label: embassy-phylip_fprogramname
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding container image retrieval (no space
  left on device).\n\nTool homepage: http://emboss.open-bio.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/embassy-phylip:3.69.650--ha92aebf_2
stdout: embassy-phylip_fprogramname.out
