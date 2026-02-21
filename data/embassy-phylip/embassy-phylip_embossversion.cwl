cwlVersion: v1.2
class: CommandLineTool
baseCommand: embossversion
label: embassy-phylip_embossversion
doc: "Report the current EMBOSS version number. Note: The provided help text contains
  only system error messages regarding container execution and does not list specific
  command-line arguments.\n\nTool homepage: http://emboss.open-bio.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/embassy-phylip:3.69.650--ha92aebf_2
stdout: embassy-phylip_embossversion.out
