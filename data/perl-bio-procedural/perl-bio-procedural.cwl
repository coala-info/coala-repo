cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bio-procedural
label: perl-bio-procedural
doc: "BioPerl procedural interface. (Note: The provided text is a system error log
  regarding a container build failure and does not contain help documentation or argument
  definitions.)\n\nTool homepage: https://metacpan.org/release/Bio-Procedural"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-procedural:1.7.4--pl5321hdfd78af_1
stdout: perl-bio-procedural.out
