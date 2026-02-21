cwlVersion: v1.2
class: CommandLineTool
baseCommand: clustalw2
label: perl-bio-tools-run-alignment-clustalw_clustalw2
doc: "ClustalW2 is a general purpose multiple sequence alignment program for DNA or
  proteins.\n\nTool homepage: https://metacpan.org/release/Bio-Tools-Run-Alignment-Clustalw"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-tools-run-alignment-clustalw:1.7.4--pl526_0
stdout: perl-bio-tools-run-alignment-clustalw_clustalw2.out
