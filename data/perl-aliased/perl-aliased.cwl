cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-aliased
label: perl-aliased
doc: "The perl-aliased tool (Note: The provided text is an error log indicating the
  executable was not found, so no usage information or arguments could be extracted).\n
  \nTool homepage: https://www.gnu.org/software/sed/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-aliased:0.34--pl526_2
stdout: perl-aliased.out
