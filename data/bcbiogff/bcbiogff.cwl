cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcbiogff
label: bcbiogff
doc: "A tool for working with GFF files (Note: The provided text is an error log and
  does not contain help documentation or argument details).\n\nTool homepage: https://github.com/chapmanb/bcbb/blob/master/gff"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcbiogff:0.6.6--pyh864c0ab_2
stdout: bcbiogff.out
