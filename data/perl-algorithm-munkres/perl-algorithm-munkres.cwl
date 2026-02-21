cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-algorithm-munkres
label: perl-algorithm-munkres
doc: "Perl implementation of the Munkres (Hungarian) algorithm for the Assignment
  Problem.\n\nTool homepage: https://github.com/clearlinux-pkgs/perl-Algorithm-Munkres"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-algorithm-munkres:0.08--pl526_1
stdout: perl-algorithm-munkres.out
