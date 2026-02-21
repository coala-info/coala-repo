cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-tie-cache
label: perl-tie-cache
doc: "A Perl tool or module related to Tie::Cache (Note: The provided text contains
  only execution error logs and no help documentation; therefore, no arguments could
  be extracted).\n\nTool homepage: https://github.com/CNTRUN/Termux-command"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-tie-cache:0.21--0
stdout: perl-tie-cache.out
