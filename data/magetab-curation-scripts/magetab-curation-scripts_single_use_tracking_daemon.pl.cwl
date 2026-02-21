cwlVersion: v1.2
class: CommandLineTool
baseCommand: magetab-curation-scripts_single_use_tracking_daemon.pl
label: magetab-curation-scripts_single_use_tracking_daemon.pl
doc: "A single-use tracking daemon script for MAGE-TAB curation.\n\nTool homepage:
  https://github.com/ebi-gene-expression-group/perl-curation-scripts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/magetab-curation-scripts:1.1.0--hdfd78af_0
stdout: magetab-curation-scripts_single_use_tracking_daemon.pl.out
