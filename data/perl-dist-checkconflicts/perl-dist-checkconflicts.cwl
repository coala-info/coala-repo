cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-dist-checkconflicts
label: perl-dist-checkconflicts
doc: "A tool to check for conflicts in Perl distributions. (Note: The provided text
  is an error log and does not contain usage instructions or argument definitions.)\n
  \nTool homepage: https://github.com/pld-linux/perl-Dist-CheckConflicts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-dist-checkconflicts:0.11--0
stdout: perl-dist-checkconflicts.out
