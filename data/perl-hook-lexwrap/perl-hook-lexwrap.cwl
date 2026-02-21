cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-hook-lexwrap
label: perl-hook-lexwrap
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be an error log indicating that the executable was not found
  in the environment.\n\nTool homepage: https://github.com/karenetheridge/Hook-LexWrap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-hook-lexwrap:0.26--pl526_1
stdout: perl-hook-lexwrap.out
