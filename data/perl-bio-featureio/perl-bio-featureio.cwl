cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bio-featureio
label: perl-bio-featureio
doc: 'BioPerl module for reading and writing sequence features in various formats
  (e.g., GFF, BED, GTF). Note: The provided help text contains only system error logs
  regarding a failed container build and does not list specific command-line arguments.'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-featureio:1.6.905--0
stdout: perl-bio-featureio.out
