cwlVersion: v1.2
class: CommandLineTool
baseCommand: magetab-curation-scripts_launch_tracking_daemons.pl
label: magetab-curation-scripts_launch_tracking_daemons.pl
doc: "Launch tracking daemons for MAGE-TAB curation scripts. Note: The provided help
  text contains only system error messages regarding container execution and does
  not list specific command-line arguments.\n\nTool homepage: https://github.com/ebi-gene-expression-group/perl-curation-scripts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/magetab-curation-scripts:1.1.0--hdfd78af_0
stdout: magetab-curation-scripts_launch_tracking_daemons.pl.out
