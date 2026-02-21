cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bio-kmer
label: perl-bio-kmer
doc: "The provided text is a container build error log (Apptainer/Singularity) indicating
  a 'no space left on device' failure during image extraction. It does not contain
  CLI help text or argument definitions for the tool.\n\nTool homepage: https://metacpan.org/pod/Bio::Kmer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-kmer:0.55--pl5321h031d066_0
stdout: perl-bio-kmer.out
