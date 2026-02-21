cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bio-phylo
label: perl-bio-phylo
doc: "The provided text does not contain help information or a description for the
  tool. It appears to be a log of a failed container build/fetch process (Apptainer/Singularity)
  due to insufficient disk space.\n\nTool homepage: https://metacpan.org/pod/Bio::Phylo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-phylo:2.0.2--pl5321hdfd78af_0
stdout: perl-bio-phylo.out
