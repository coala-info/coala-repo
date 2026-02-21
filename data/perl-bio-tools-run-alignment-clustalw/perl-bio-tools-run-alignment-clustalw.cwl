cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bio-tools-run-alignment-clustalw
label: perl-bio-tools-run-alignment-clustalw
doc: "A BioPerl wrapper for running ClustalW alignments. Note: The provided text contains
  system error logs indicating a failure to initialize the container environment (no
  space left on device) rather than the tool's help documentation.\n\nTool homepage:
  https://metacpan.org/release/Bio-Tools-Run-Alignment-Clustalw"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-tools-run-alignment-clustalw:1.7.4--pl526_0
stdout: perl-bio-tools-run-alignment-clustalw.out
